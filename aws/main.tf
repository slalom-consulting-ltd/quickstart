# AWS infrastructure resources

resource "tls_private_key" "global_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "ssh_private_key_pem" {
  filename          = "${path.module}/id_rsa"
  sensitive_content = tls_private_key.global_key.private_key_pem
  file_permission   = "0600"
}

resource "local_file" "ssh_public_key_openssh" {
  filename = "${path.module}/id_rsa.pub"
  content  = tls_private_key.global_key.public_key_openssh
}

# Temporary key pair used for SSH accesss
resource "aws_key_pair" "quickstart_key_pair" {
  key_name_prefix = "${var.prefix}-rancher-"
  public_key      = tls_private_key.global_key.public_key_openssh
}

# Security group to allow TLS to rancher-server
resource "aws_security_group" "rancher_sg_tls2server" {
  name        = "${var.prefix}-rancher-tls2server"
  description = "Rancher quickstart - allow external tls to server"
  vpc_id      = var.vpc_id


  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "TCP"
    cidr_blocks = var.external_access_cidr_blocks
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.common_tags
}

# Security group to allow all traffic
resource "aws_security_group" "rancher_sg_allowall" {
  name        = "${var.prefix}-rancher-allowall"
  description = "Rancher quickstart - allow all traffic internally"
  vpc_id      = var.vpc_id


  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port = "-1"
    to_port   = "-1"
    protocol  = "icmp"
    self      = true
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  ingress {
    from_port   = "6443"
    to_port     = "6443"
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.common_tags
}

# AWS EC2 instance for creating a single node RKE cluster and installing the Rancher server
resource "aws_instance" "rancher_server" {
  Name                        = "${var.prefix}-rancher-server"
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id_public
  iam_instance_profile        = aws_iam_instance_profile.rancher_profile.name
  depends_on = [
    aws_iam_role_policy.rancher_iam_policy,
    aws_security_group.rancher_sg_allowall,
  ]

  key_name = aws_key_pair.quickstart_key_pair.key_name
  vpc_security_group_ids = [
    aws_security_group.rancher_sg_allowall.id,
    aws_security_group.rancher_sg_tls2server.id,
  ]

  user_data = templatefile(
    join("/", [path.module, "../cloud-common/files/userdata_rancher_server.template"]),
    {
      docker_version = var.docker_version
      username       = var.node_username
    }
  )

  root_block_device {
    volume_size = 16
    encrypted   = true
    kms_key_id  = var.ebs_kms_key_id

  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.private_ip
      user        = var.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }

  tags = var.common_tags
}


# AWS EC2 instance for creating a single node workload cluster
resource "aws_instance" "quickstart_node" {
  ami                  = data.aws_ami.ubuntu.id
  subnet_id            = var.subnet_id_private
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.rancher_profile.name

  key_name               = aws_key_pair.quickstart_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.rancher_sg_allowall.id]


  user_data = templatefile(
    join("/", [path.module, "files/userdata_quickstart_node.template"]),
    {
      docker_version   = var.docker_version
      username         = var.node_username
      register_command = module.rancher_common.custom_cluster_command
    }
  )

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.private_ip
      user        = var.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }

  tags = merge(
    {
      Name = "${var.prefix}-quickstart-node"
    },
  var.common_tags)

}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = var.amivalues
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

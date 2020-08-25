resource "aws_iam_instance_profile" "rancher_profile" {
  name = var.iam_profile_name
  role = aws_iam_role.rancher_role.name
}

resource "aws_iam_role_policy_attachment" "ec2roleforssm" {
  role       = aws_iam_role.rancher_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role" "rancher_role" {
  name = var.role_name
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
              "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF

  tags = var.common_tags
}

resource "aws_iam_role_policy" "rancher_iam_policy" {
  name   = var.role_policy_name
  role   = aws_iam_role.rancher_role.id
  policy = data.iam_policy_document.json
}

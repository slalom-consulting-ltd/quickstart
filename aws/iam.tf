resource "aws_iam_instance_profile" "rancher_profile" {
  name = "rancher_iam_profile"
  role = aws_iam_role.rancher_role.name
}

resource "aws_iam_role" "rancher_role" {
  name = "rancher_iam_role"
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
}
resource "aws_iam_role_policy" "rancher_iam_policy" {
  name   = "rancher_iam_policy"
  role   = aws_iam_role.rancher_role.id
  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "ec2:Describe*",
          "s3:ListAllMyBuckets"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}
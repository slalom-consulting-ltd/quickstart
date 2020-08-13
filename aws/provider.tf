provider "aws" {
# shared_credentials_file = var.aws_credentials_path
  profile = var.aws_credentials_profile
  region     = var.aws_region
}

provider "tls" {
}

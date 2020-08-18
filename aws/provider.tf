provider "aws" {
  region  = var.aws_region
  version = "3.1.0"
}

provider "tls" {
  version = "2.2.0"
}

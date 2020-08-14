# Variables for AWS infrastructure module
// TODO - use null defaults

# notRequired
# variable "aws_access_key" {
#   type        = string
#   description = "AWS access key used to create infrastructure"
# }

# # notRequired
# variable "aws_secret_key" {
#   type        = string
#   description = "AWS secret key used to create AWS infrastructure"
# }

# variable "aws_credentials_path" {
#   type        = string
#   description = "AWS cli credentials path"
# }

# variable "aws_credentials_profile" {
#   type        = string
#   description = "AWS cli creds profile name"
# }

variable "aws_region" {
  type        = string
  description = "AWS region used for all resources"
}

# variable "public_tls_ips" {
#   type        = list
#   description = "IP addresses to access rancher-server over https"
# }

variable "vpc_id" {
  type        = string
  description = "VPC ID (assuming non-default)"
}

variable "subnet_id_1" {
  type        = string
  description = "Subnet for node1 (if exists)"
}

variable "subnet_id_2" {
  type        = string
  description = "Subnet for node2 (if exists)"
}

variable "ebs_kms_key_id" {
  type        = string
  description = "AWS Account default EBS encryption key"
}

variable "prefix" {
  type        = string
  description = "Prefix added to names of all resources"
  default     = "quickstart"
}

variable "instance_type" {
  type        = string
  description = "Instance type used for all EC2 instances"
  default     = "t3a.medium"
}

variable "docker_version" {
  type        = string
  description = "Docker version to install on nodes"
  default     = "19.03"
}

variable "rke_kubernetes_version" {
  type        = string
  description = "Kubernetes version to use for Rancher server RKE cluster"
  default     = "v1.18.3-rancher2-2"
}

variable "workload_kubernetes_version" {
  type        = string
  description = "Kubernetes version to use for managed workload cluster"
  default     = "v1.17.6-rancher2-2"
}

variable "cert_manager_version" {
  type        = string
  description = "Version of cert-mananger to install alongside Rancher (format: 0.0.0)"
  default     = "0.12.0"
}

variable "rancher_version" {
  type        = string
  description = "Rancher server version (format: v0.0.0)"
  default     = "v2.4.5"
}

# Required
variable "rancher_server_admin_password" {
  type        = string
  description = "Admin password to use for Rancher server bootstrap"
}


# Local variables used to reduce repetition
locals {
  node_username = "ubuntu"
}

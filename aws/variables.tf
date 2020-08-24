
variable "aws_region" {
  type        = string
  description = "AWS region used for all resources"
}

variable "amivalues" {
  type        = list
  default     = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  description = "Set values for ami filter"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID (assuming non-default)"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR Block (assuming non-default)"
}

variable "external_access_cidr_blocks" {
  type        = list
  description = "IP addresses for external HTTPS access (if any)"
  default     = ["214.95.32.102/32", "37.98.124.53/32"]
}

variable "subnet_id_public" {
  type        = string
  description = "Subnet for rancher_server (if exists)"
}

variable "subnet_id_private" {
  type        = string
  description = "Subnet for aws_quickstart_rke_cluster (if exists)"
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
  validation {
    condition = (
      length(var.rancher_server_admin_password) > 7
    )
    error_message = "Blank password or password too short."
  }
}


# Local variables used to reduce repetition
locals {
  node_username = "ubuntu"
}

variable "iam_profile_name" {
  type    = string
  default = "rancher_iam_profile"
}

variable "role_name" {
  type        = string
  description = "The role name"
  default     = "rancher_iam_role"
}

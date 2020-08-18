# Required variables
# - Fill in before beginning quickstart
# ==========================================================


# Password used to log in to the `admin` account on the new Rancher server
rancher_server_admin_password = ""

# VPC for deployment
vpc_id = ""

# VPC for deployment
vpc_cidr_block = ""

# Subnet for node1
subnet_id_public = ""

# Subnet for node2
subnet_id_private = ""

# AWS Account regional-local default EBS KeyID
ebs_kms_key_id = ""

# IP addresses needing external HTTPS access to Rancher_Server
external_access_cidr_blocks = ""

# Optional variables, uncomment to customize the quickstart
# ----------------------------------------------------------

# AWS region for all resources
# aws_region = ""

# Prefix for all resources created by quickstart
# prefix = ""

# EC2 instance size of all created instances
# instance_type = ""

# Docker version installed on target hosts
# - Must be a version supported by the Rancher install scripts
# docker_version = ""

# Kubernetes version used for creating management server cluster
# - Must be supported by RKE terraform provider 1.0.1
# rke_kubernetes_version = ""

# Kubernetes version used for creating workload cluster
# - Must be supported by RKE terraform provider 1.0.1
# workload_kubernetes_version = ""

# Version of cert-manager to install, used in case of older Rancher versions
# cert_manager_version = ""

# Version of Rancher to install
# rancher_version = ""

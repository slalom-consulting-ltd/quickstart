# RKE resources
# Provision RKE cluster on provided infrastructure
resource "rke_cluster" "rancher_cluster" {
  cluster_name = "quickstart-rancher-server"
  kubernetes_version = var.rke_kubernetes_version

  nodes {
    address          = var.node_internal_ip
    internal_address = var.node_internal_ip
    user             = var.node_username
    role             = ["controlplane", "etcd", "worker"]
    ssh_key          = var.ssh_private_key_pem
  }
  cloud_provider{
    name = aws
  }
}


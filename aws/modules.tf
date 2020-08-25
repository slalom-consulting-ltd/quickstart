# Rancher resources
module "rancher_common" {
  source = "../rancher-common"

  node_public_ip         = aws_instance.rancher_server.private_ip
  node_internal_ip       = aws_instance.rancher_server.private_ip
  node_username          = var.node_username
  ssh_private_key_pem    = tls_private_key.global_key.private_key_pem
  rke_kubernetes_version = var.rke_kubernetes_version

  cert_manager_version = var.cert_manager_version
  rancher_version      = var.rancher_version

  rancher_server_dns = aws_instance.rancher_server.public_dns
  #  rancher_server_dns = join(".", ["rancher", aws_instance.rancher_server.public_ip, "xip.io"])
  admin_password = var.rancher_server_admin_password

  workload_kubernetes_version = var.workload_kubernetes_version
  workload_cluster_name       = "quickstart-aws-custom"
}

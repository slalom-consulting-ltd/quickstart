terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.10.0"
    }

    rke = {
      source  = "rancher/rke"
      version = "1.0.1"
    }

    tls = {
      version = "2.2.0"
    }

    local = {
      version = "1.4.0"
    }

    helm = {
      version = "1.2.4"
    }

    kubernetes = {
      version = "1.12.0"
    }
  }
}

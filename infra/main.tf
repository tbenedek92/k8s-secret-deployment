terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.26.1"
    }
  }
  backend "gcs" {
    bucket      = "tf-state-k8s-secret-deployment"
    prefix      = "demo"
    credentials = "service-account.json"
  }
}

provider "linode" {
  token = var.token
}

resource "linode_lke_cluster" "lke_cluster" {
  label       = var.label
  k8s_version = "1.22"
  region      = var.region

  pool {
    type  = var.pool_type
    count = var.pool_count
  }
}

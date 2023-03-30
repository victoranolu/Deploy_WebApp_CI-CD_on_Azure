provider "kubernetes" {
  config_path    = "~/.kube/config"
}

resource "kubernetes_namespace" "kube-namespace" {
  metadata {
    name = "sock-shop"
  }
}
resource "kubernetes_namespace" "prome" {
  metadata {
    name = "prometheus"
  } 
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "45.7.1"
  namespace = kubernetes_namespace.prome.id

  values = [
    "${file("values.yaml")}"
  ]

  set {
    name  = "podSecurityPolicy.enabled"
    value = "true"
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = "false"
  }

  set {
    name  = "server\\.resources"
    value = yamlencode({
        limits = {
            cpu = "200m"
            memory ="50Mi"
        }
        requests = {
            cpu = "100m"
            memory = "30Mi"
        }
    })
  }
}
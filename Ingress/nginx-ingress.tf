resource "kubernetes_ingress_v1" "azure-voting-ingress" {
  metadata {
    name      = "vote-front"
    namespace = "vote-app"
    labels = {
      name = "vote-front"
    }
    annotations = {
      "kubernetes.io/ingress.class" : "nginx"
      "cert-manager.io/cluster-issuer" : "letsencrypt"
    }
  }

  spec {
    tls {
      hosts = [ "web.poormanalfred.me" ]
      secret_name = "mansodan"
    }
    rule {
      host = "web.poormanalfred.me"
      http {
        path {
          backend {
            service {
              name = "azure-vote-front"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "sock-ingress" {
  metadata {
    name      = "sock-shop"
    namespace = "sock-shop"
    labels = {
      name = "front-end"
    }
    annotations = {
      "kubernetes.io/ingress.class" : "nginx"
      "cert-manager.io/cluster-issuer" : "letsencrypt"
    }
  }

  spec {
    tls {
      hosts = [ "poormanalfred.me" ]
      secret_name = "mansodan"
    }
    rule {
      host = "poormanalfred.me"
      http {
        path {
          backend {
            service {
              name = "front-end"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

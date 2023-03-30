provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "test" {
  metadata {
    name = "vote-app"
  }
}
resource "kubernetes_deployment" "vote-app-dep" {
  metadata {
    name      = "azure-vote-back"
    namespace = kubernetes_namespace.test.metadata.0.name
    labels = {
      name = "voting-app"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "azure-vote-back"
      }
    }
    template {
      metadata {
        name = "azure-vote-back"
        labels = {
          app = "azure-vote-back"
        }
      }
      spec {
        container {
          image = "mcr.microsoft.com/oss/bitnami/redis:6.0.8"
          name  = "azure-vote-back"
          port {
            container_port = 6379
            name           = "redis"
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "testing" {
  metadata {
    name      = "azure-vote-back"
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.vote-app-dep.spec.0.template.0.metadata.0.labels.app
    }
    port {
      port        = 6379
      target_port = 6379
    }
  }
}


resource "kubernetes_deployment" "testing-app" {
  metadata {
    name      = "azure-vote-front"
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "azure-vote-front"
      }
    }
    strategy {
      rolling_update {
        max_surge       = 1
        max_unavailable = 1
      }
    }
    min_ready_seconds = 5

    template {
      metadata {
        name = "azure-vote-back"
        labels = {
          app = "azure-vote-front"
        }
      }
      spec {
        container {
          image = "mcr.microsoft.com/azuredocs/azure-vote-front:v1"
          name  = "azure-vote-front"
          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu = "500m"
            }
          }
          env {
            name  = "redis"
            value = "azure-vote-back"
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "testing-serv" {
  metadata {
    name      = "azure-vote-front"
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.testing-app.spec.0.template.0.metadata.0.labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}
resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "nginx"
  }
}

# Install Nginx Ingress using Helm Chart
resource "helm_release" "nginx_ingress" {
  name       = "nginx"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  namespace  = "nginx"

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "podSecurityPolicy.enabled"
    value = true
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = false
  }

  set {
    name  = "replicaCount"
    value = 1
  }
   
  set {
    name = "controller.service.loadBalancerIP"      # This will deploy but would/might have the load balancer IP pending and therefore not fully installed due to the set value here. Alternative you can comment this line out and manually set the Azure A record directly to the load balancer IP on the portal. 
    value = azurerm_public_ip.Pub-IP.ip_address
  } 

  set {
    type  = "string"
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io"
    value = "myname"
  }
}
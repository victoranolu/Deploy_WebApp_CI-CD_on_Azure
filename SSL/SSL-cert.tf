resource "kubernetes_namespace" "ns" {
  metadata {
    name = "cert-manager"
  }
}



resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.7.1"

  namespace = "cert-manager"

  #values = [file("cert-manager-values.yaml")]

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "image.repository"
    value = "quay.io/jetstack/cert-manager-controller"
  }

  set {
    name  = "webhook.securePort"
    value = "10260"
  }

  set {
    name  = "controller.nodeSelector\\.beta.kubernetes.io/os"
    value = "linux"
  }

}

resource "kubectl_manifest" "ca_cluster" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: osehodionanolu@gmail.com
    privateKeySecretRef:
      name: letsencrypt-private-key
    solvers:
    - http01:
        ingress:
          class: nginx
YAML                
}
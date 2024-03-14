resource "helm_release" "cert_manager" {
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.14.3"
  name       = "${var.stack}-cert-manager"
  namespace  = var.namespace
  atomic     = true
  values = [
    yamlencode({
      installCRDs = true
      serviceAccount = {
        create = false
        name   = kubernetes_service_account.cert-manager-sa.metadata[0].name
      }
    })
  ]
}

resource "kubernetes_service_account" "default" {
  count = length(var.service_accounts) > 0 ? length(var.service_accounts) : 0
  metadata {
    name = var.service_accounts[count.index].name
    namespace = var.service_accounts[count.index].namespace
  }
}
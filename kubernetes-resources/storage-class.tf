resource "kubernetes_storage_class" "default" {
  count = length(var.storage_classes) > 0 ? length(var.storage_classes) : 0
  metadata {
    name = var.storage_classes[count.index].name
    namespace = var.storage_classes[count.index].namespace
  }
  storage_provisioner = var.storage_classes[count.index].provisioner
  reclaim_policy      = var.storage_classes[count.index].reclaim_policy
  parameters = {
    type = var.storage_classes[count.index].parameter_type
    encrypted = var.storage_classes[count.index].parameter_encrypted
  }
  mount_options = var.storage_classes[count.index].mount_options
}
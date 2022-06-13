resource "helm_release" "default" {
  count = length(var.resources_list)
  name  = var.resources_list[count.index].name
  create_namespace = true
  repository = var.resources_list[count.index].repository
  chart = var.resources_list[count.index].chart

  timeout = var.resources_list[count.index].timeout
  cleanup_on_fail = var.resources_list[count.index].cleanup_on_fail
  force_update    = var.resources_list[count.index].for_update
  namespace       = var.resources_list[count.index].namespace

  dynamic "set" {
    for_each = var.resources_list[count.index].set_list
    name = set_list.value.name
    value = set_list.value.value
  }
  depends_on = [
    data.terraform_remote_state.eks,
    data.aws_eks_cluster.cluster
  ]
}
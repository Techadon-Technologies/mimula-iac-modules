resource "kubernetes_namespace" "default" {
  count = length(var.namespaces) > 0 ? length(var.namespaces) : 0
  metadata {
    annotations = {
      name = var.namespaces[count.index].name
    }
    name = var.namespaces[count.index].name
  }
  depends_on = [
    data.aws_eks_cluster.cluster,
    data.aws_eks_node_groups.node_group
  ]
}
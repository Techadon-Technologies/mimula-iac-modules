data "aws_eks_cluster" "cluster" {
  name = var.cluster_id
}
data "aws_eks_node_group" "node_group" {
  name = var.cluster_id
  node_group_name = var.cluster_id
}
data "aws_eks_cluster" "cluster" {
  name = var.cluster_id
}
data "aws_eks_node_groups" "node_group" {
  name = var.cluster_id
}
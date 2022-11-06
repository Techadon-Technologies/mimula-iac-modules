resource "aws_elasticache_cluster" "default" {
  cluster_id           = var.cluster_name
  engine               = var.cluster_engine
  node_type            = var.cluster_node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.parameter_group_name
  engine_version       = var.cluster_engine_version
  port                 = var.cluster_port
}
output "cluster_subnet_groups_name" {
  value = aws_elasticache_subnet_group.default.name
  description = "cluster subnet groups name"
}

output "cluster_arn" {
  value = aws_elasticache_cluster.default.arn
  description = "cluster arn"
}

output "cluster_address" {
  value = aws_elasticache_cluster.default.cluster_address
  description = "cluster cluster_address"
}

output "cluster_endpoint" {
  value = aws_elasticache_cluster.default.configuration_endpoint
  description = "cluster configuration_endpoint"
}

output "cluster_nodes" {
  value = aws_elasticache_cluster.default.cache_nodes
  description = "cluster cache_nodes"
}


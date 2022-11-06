resource "aws_elasticache_subnet_group" "default" {
  name       = "${var.cluster_name}-cache-subnet"
  subnet_ids = var.subnets
  tags = merge(
    var.glogal_tags,
    {
        Name = "${var.cluster_name}-cache-subnet"
    }
  )
}
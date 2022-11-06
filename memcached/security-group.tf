resource "aws_elasticache_security_group" "default" {
  name                 = "${var.cluster_name}-elasticache-security-group"
  security_group_names = var.security_groups
}
resource "aws_security_group" "default" {
  count = var.endpoint_enabled == true && var.vpc_endpoint_type == "Interface" ? 1 : 0
  name        = "${lower(var.global_tags.Author)}_${var.global_tags.Environment}-vpc-endpoint-security-group"
  description = "Allow HTTP, HTTPS and SSH traffic for ${lower(var.global_tags.Author)}_${var.global_tags.Environment} eni"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.endpoint_sg_rules_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = try(ingress.value.cidr_blocks, null)
      self = try(ingress.value.self, false)
      security_groups = try(ingress.value.security_groups, null)
    }
  }

  dynamic "egress" {
    for_each = var.endpoint_sg_rules_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = [egress.value.cidr_blocks]
    }
  }

  tags = merge(
    var.global_tags,
    {
      "Name" = "${lower(var.global_tags.Author)}_${var.global_tags.Environment}-security-group"
    },
  )
}
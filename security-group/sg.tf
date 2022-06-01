# data "aws_security_group" "selected" {
#   name = var.global_tags.Name
# }

resource "aws_security_group" "default" {
  # count = data.aws_security_group.selected.id != null ? 0 : 1
  name        = var.sg_name
  description = "Allow HTTP, HTTPS and SSH traffic for ${lower(var.global_tags.Author)}_${var.global_tags.Environment} eni"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_rules_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = try(ingress.value.cidr_blocks, null) == null ? null : [ingress.value.cidr_blocks]
      self = try(ingress.value.self, false)
      security_groups = try(ingress.value.security_groups, null)
    }
  }

  dynamic "egress" {
    for_each = var.sg_rules_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = [egress.value.cidr_blocks]
    }
  }

  tags = var.global_tags
}
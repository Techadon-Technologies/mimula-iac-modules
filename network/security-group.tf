# Mimula
# author LTM 

resource "aws_security_group" "default" {
  name        = "${var.project_name}_default-security-group"
  description = "Allow HTTP, HTTPS and SSH traffic"
  vpc_id = aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.default_sg_rules_ingress
    content {
        description = ingress.value.description
        from_port   = ingress.value.from_port
        to_port     = ingress.value.to_port
        protocol    = ingress.value.protocol
        cidr_blocks = [ingress.value.cidr_blocks]
    }
  }

  dynamic "egress" {
    for_each = var.default_sg_rules_egress
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
      "Name" = "${var.project_name}_default_sg"
    },
  )
}
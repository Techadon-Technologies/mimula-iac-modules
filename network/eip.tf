# Mimula
# author LTM 

resource "aws_eip" "nat" {
  count = var.nats_enabled ? var.az_count : 0
  tags  = var.global_tags
  vpc   = true
}
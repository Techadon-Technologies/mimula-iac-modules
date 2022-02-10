# Mimula
# author LTM 

resource "aws_eip" "nat" {
  count = var.az_count
  tags  = var.global_tags
  vpc   = true
}
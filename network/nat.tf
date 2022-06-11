# Mimula
# author LTM 

resource "aws_nat_gateway" "default" {
  count         = var.nats_enabled ? var.az_count : 0
  subnet_id     = element(aws_subnet.default_public_subnet.*.id, count.index)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  tags          = merge(
    var.global_tags,
    {
      Name = "${var.project_name}_Nat_${count.index}"
    }
  )
  depends_on = [
    aws_internet_gateway.default,
    aws_eip.nat,
    aws_subnet.default_public_subnet,
  ]
  lifecycle {
    ignore_changes = [tags]
  }
}
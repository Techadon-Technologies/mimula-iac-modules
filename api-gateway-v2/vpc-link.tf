resource "aws_apigatewayv2_vpc_link" "default" {
  for_each = var.create_vpc_link ? var.vpc_links : {}

  name               = lookup(each.value, "name", each.key)
  security_group_ids = each.value["security_group_ids"]
  subnet_ids         = each.value["subnet_ids"]

  tags = merge(var.tags, {"Name" = "VPC Link", "Usecase": "vpc resources access"})
}
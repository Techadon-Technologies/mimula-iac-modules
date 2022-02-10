resource "aws_vpc_endpoint" "default" {
  count = var.endpoint_enabled == true ? 1 : 0
  vpc_id       = var.vpc_id
  service_name = var.service_name
  vpc_endpoint_type = var.vpc_endpoint_type
  private_dns_enabled = var.vpc_endpoint_type == "Interface" ? var.private_dns_enabled : false
  security_group_ids = var.vpc_endpoint_type == "Interface" ? [join("", aws_security_group.default.*.id)] : null
  subnet_ids = var.vpc_endpoint_type == "Interface" ? var.subnet_ids : null
}

resource "aws_vpc_endpoint_route_table_association" "route_table_association" {
  count = var.endpoint_enabled == true && var.vpc_endpoint_type == "Gateway" ? 1 : 0
  route_table_id  = var.route_table_id
  vpc_endpoint_id = join("", aws_vpc_endpoint.default.*.id)
}   
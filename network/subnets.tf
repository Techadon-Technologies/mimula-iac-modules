# Mimula
# author LTM 

//////public subnet
# its just holding nats for now
resource "aws_subnet" "default_public_subnet" {
  count             = var.az_count
  vpc_id            = aws_vpc.default.id
  cidr_block        = "${var.vpc_cidr_base}${var.public_subnet_cidrs[format("zone%d", count.index)]}"
  availability_zone = element(split(",", var.aws_azs), count.index)
  map_public_ip_on_launch = true
  tags = merge(
    var.global_tags,
    {
      "Name" = "${var.project_name}_public_subnet_az${count.index + 1}"
    },
  )
  depends_on = [
    aws_vpc.default,
  ]
}

resource "aws_route_table_association" "default_public_assoc" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.default_public_subnet.*.id, count.index)
  route_table_id = aws_route_table.default_public.id
}


//////// private subnets
# has all private resouces
resource "aws_subnet" "default_private_subnet" {
  count             = var.az_count
  vpc_id            = aws_vpc.default.id
  cidr_block        = "${var.vpc_cidr_base}${var.private_subnet_cidrs[format("zone%d", count.index)]}"
  availability_zone = element(split(",", var.aws_azs), count.index)
  tags = merge(
    var.global_tags,
    {
      "Name" = "${var.project_name}_private_subnet_az${count.index + 1}"
    },
  )
  depends_on = [
    aws_vpc.default,
  ]
}

resource "aws_route_table_association" "default_private_assoc" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.default_private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.default_private.*.id, count.index)
}
# Mimula
# author LTM 

output "aws_vpc" {
  value = aws_vpc.default.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.default.id
}

output "aws_security_group" {
  value = aws_security_group.default.id
}

output "aws_public_subnet" {
  value = aws_subnet.default_public_subnet[0].id
}

output "aws_public_subnets" {
  value = aws_subnet.default_public_subnet.*.id
}

output "aws_private_subnet" {
  value = aws_subnet.default_private_subnet[0].id
}

output "aws_private_subnets" {
  value = aws_subnet.default_private_subnet.*.id
}

output "aws_nat_gateway_count" {
  value = length(aws_nat_gateway.default.*.id)
}

output "aws_nat_gateway_ids" {
  value = aws_nat_gateway.default.*.id
}
output "aws_eip_nat_ips" {
  value = aws_eip.nat.*.public_ip
}
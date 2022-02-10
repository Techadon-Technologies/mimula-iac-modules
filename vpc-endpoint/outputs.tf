output "id" {
  description = "vpc endpoint id"
  value       = join("", aws_vpc_endpoint.default.*.id)
}

output "arn" {
  description = "vpc endpoint arn"
  value       = join("", aws_vpc_endpoint.default.*.arn)
}
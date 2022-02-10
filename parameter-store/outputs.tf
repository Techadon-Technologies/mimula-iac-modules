output "name" {
  value = join("", aws_ssm_parameter.default.*.name)
  description = "ssm parameter name"
}

output "arn" {
  value = join("", aws_ssm_parameter.default.*.arn)
  description = "ssm parameter arn"
}
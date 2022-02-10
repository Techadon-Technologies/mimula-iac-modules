output "arn" {
  value = aws_cloudwatch_log_group.default.arn
  description = "log group arn"
}
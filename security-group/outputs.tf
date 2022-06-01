output "security_group_id" {
  value       =  aws_security_group.default.id
  # value       =  data.aws_security_group.selected.id != null ? data.aws_security_group.selected.id : aws_security_group.default[0].id
  description = "EC2 instance Security Group ID"
}

output "security_group_arn" {
  value       = aws_security_group.default.arn
  # value       = data.aws_security_group.selected.id != null ? data.aws_security_group.selected.arn : aws_security_group.default[0].arn
  description = "EC2 instance Security Group ARN"
}

output "security_group_name" {
  value       = aws_security_group.default.name
  # value       = data.aws_security_group.selected.id != null ? data.aws_security_group.selected.name : aws_security_group.default[0].name
  description = "EC2 instance Security Group name"
}
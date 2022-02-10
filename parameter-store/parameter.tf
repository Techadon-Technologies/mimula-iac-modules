resource "aws_ssm_parameter" "default" {
  count = length(var.parameters) > 0 ? length(var.parameters) : 0
  name        = var.parameters[count.index].parameter_name
  description = var.parameters[count.index].parameter_description
  type        = var.parameters[count.index].parameter_type
  value       = var.parameters[count.index].parameter_value

  tags = var.global_tags
}
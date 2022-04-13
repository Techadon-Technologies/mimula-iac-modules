resource "aws_api_gateway_stage" "default" {
  deployment_id        = aws_api_gateway_deployment.default.id
  rest_api_id          = aws_api_gateway_rest_api.default.id
  stage_name           = module.default.stage
  xray_tracing_enabled = var.xray_tracing_enabled
  tags                 = module.default.tags

  variables = {
    vpc_link_id = local.vpc_link_enabled ? aws_api_gateway_vpc_link.default.id : null
  }

  dynamic "access_log_settings" {
    for_each = var.log_group_arn ? [1] : []

    content {
      destination_arn = var.log_group_arn
      format          = replace(var.access_log_format, "\n", "")
    }
  }
}
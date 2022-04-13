resource "aws_apigatewayv2_stage" "default" {
  count = var.create_default_stage ? 1 : 0

  api_id      = aws_apigatewayv2_api.default.id
  name        = "$default"
  auto_deploy = true

  dynamic "access_log_settings" {
    for_each = var.default_stage_access_log_destination_arn != null && var.default_stage_access_log_format != null ? [true] : []
    content {
      destination_arn = var.default_stage_access_log_destination_arn
      format          = var.default_stage_access_log_format
    }
  }

  dynamic "default_route_settings" {
    for_each = length(keys(var.default_route_settings)) == 0 ? [] : [var.default_route_settings]
    content {
      data_trace_enabled       = lookup(default_route_settings.value, "data_trace_enabled", false)
      detailed_metrics_enabled = lookup(default_route_settings.value, "detailed_metrics_enabled", false)
      logging_level            = lookup(default_route_settings.value, "logging_level", null)
      throttling_burst_limit   = lookup(default_route_settings.value, "throttling_burst_limit", null)
      throttling_rate_limit    = lookup(default_route_settings.value, "throttling_rate_limit", null)
    }
  }

  #  # bug - https://github.com/terraform-providers/terraform-provider-aws/issues/12893
  #  dynamic "route_settings" {
  #    for_each = var.create_routes_and_integrations ? var.integrations : {}
  #    content {
  #      route_key = route_settings.key
  #      data_trace_enabled = lookup(route_settings.value, "data_trace_enabled", null)
  #      detailed_metrics_enabled         = lookup(route_settings.value, "detailed_metrics_enabled", null)
  #      logging_level         = lookup(route_settings.value, "logging_level", null)  # Error: error updating API Gateway v2 stage ($default): BadRequestException: Execution logs are not supported on protocolType HTTP
  #      throttling_burst_limit         = lookup(route_settings.value, "throttling_burst_limit", null)
  #      throttling_rate_limit         = lookup(route_settings.value, "throttling_rate_limit", null)
  #    }
  #  }

  tags = merge({"Name" = "Mimula invest api-gateway stage", "UseCase" = "stage definition"}, var.tags)

  # Bug in terraform-aws-provider with perpetual diff
  lifecycle {
    ignore_changes = [deployment_id]
  }
}
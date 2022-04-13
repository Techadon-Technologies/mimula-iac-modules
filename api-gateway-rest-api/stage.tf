# resource "aws_api_gateway_stage" "this" {
#   count                = local.enabled ? 1 : 0
#   deployment_id        = aws_api_gateway_deployment.default.id
#   rest_api_id          = aws_api_gateway_rest_api.default.id
#   stage_name           = var.stage_name
#   xray_tracing_enabled = var.xray_tracing_enabled
#   tags                 = merge({
#       "Name" = "apig stage"
#     },
#     var.tags
#   )

#   variables = {
#     vpc_link_id = aws_api_gateway_vpc_link.default.id
#   }

#   dynamic "access_log_settings" {
#     for_each = var.log_group_arn ? [1] : []

#     content {
#       destination_arn = var.log_group_arn
#       format          = replace(var.access_log_format, "\n", "")
#     }
#   }
# }
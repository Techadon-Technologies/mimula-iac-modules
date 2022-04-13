# resource "aws_api_gateway_method_settings" "default" {
#   rest_api_id = aws_api_gateway_rest_api.default.id
#   stage_name  = aws_api_gateway_stage.default.stage_name
#   method_path = "*/*"

#   settings {
#     metrics_enabled = var.metrics_enabled
#     logging_level   = var.logging_level
#   }
# }
resource "aws_api_gateway_rest_api" "default" {
  name = var.name
  body = var.openapi_config != null ? jsonencode(var.openapi_config) : null
  tags = var.tags

  endpoint_configuration {
    types = [var.endpoint_type]
  }
}
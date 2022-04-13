resource "aws_api_gateway_rest_api" "default" {
  name = var.name
  body = jsonencode(var.openapi_config)
  tags = var.tags

  endpoint_configuration {
    types = [var.endpoint_type]
  }
}
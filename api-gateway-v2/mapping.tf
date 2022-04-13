resource "aws_apigatewayv2_api_mapping" "default" {
  count = var.create_api_domain_name && var.create_default_stage && var.create_default_stage_api_mapping ? 1 : 0

  api_id      = aws_apigatewayv2_api.default.id
  domain_name = aws_apigatewayv2_domain_name.default[0].id
  stage       = aws_apigatewayv2_stage.default[0].id
}

# Routes and integrations
resource "aws_apigatewayv2_route" "default" {
  for_each = var.create_routes_and_integrations ? var.integrations : {}

  api_id    = aws_apigatewayv2_api.default.id
  route_key = each.key

  api_key_required                    = lookup(each.value, "api_key_required", null)
  authorization_type                  = lookup(each.value, "authorization_type", "NONE")
  authorizer_id                       = lookup(each.value, "authorizer_id", null)
  model_selection_expression          = lookup(each.value, "model_selection_expression", null)
  operation_name                      = lookup(each.value, "operation_name", null)
  route_response_selection_expression = lookup(each.value, "route_response_selection_expression", null)
  target                              = "integrations/${aws_apigatewayv2_integration.default[each.key].id}"

  # Not sure what structure is allowed for these arguments...
  #  authorization_scopes = lookup(each.value, "authorization_scopes", null)
  #  request_models  = lookup(each.value, "request_models", null)
}
output "id" {
  description = "The ID of the REST API"
  value       = aws_api_gateway_rest_api.default.id
}

output "root_resource_id" {
  description = "The resource ID of the REST API's root"
  value       = aws_api_gateway_rest_api.default.root_resource_id
}

output "created_date" {
  description = "The date the REST API was created"
  value       = aws_api_gateway_rest_api.default.created_date
}

output "execution_arn" {
  description = <<EOF
    The execution ARN part to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda 
    function, e.g., arn:aws:execute-api:eu-west-2:123456789012:z4675bid1j, which can be concatenated with allowed stage, 
    method and resource path.The ARN of the Lambda function that will be executed.
    EOF
  value       = aws_api_gateway_rest_api.default.execution_arn
}

output "arn" {
  description = "The ARN of the REST API"
  value       = aws_api_gateway_rest_api.default.arn
}

output "invoke_url" {
  description = "The URL to invoke the REST API"
  value       = aws_api_gateway_stage.default.invoke_url
}

output "stage_arn" {
  description = "The ARN of the gateway stage"
  value       = aws_api_gateway_stage.default.arn
}
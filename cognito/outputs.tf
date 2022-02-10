output "id" {
  value = aws_cognito_user_pool.default.id
  description = "cognito pool id"
}

output "arn" {
  value = aws_cognito_user_pool.default.arn
  description = "cognito pool arn"
}
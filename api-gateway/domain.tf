resource "aws_apigatewayv2_domain_name" "default" {
  count = var.create_api_domain_name ? 1 : 0

  domain_name = var.domain_name

  domain_name_configuration {
    certificate_arn = var.domain_name_certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  # dynamic "mutual_tls_authentication" {
  #   for_each = var.mutual_tls_authentication == null ? [] : [var.mutual_tls_authentication]
  #   content {
  #     truststore_uri     = mutual_tls_authentication.value.truststore_uri
  #     truststore_version = lookup(mutual_tls_authentication.value, "truststore_version", null)
  #   }
  # }

  tags = merge(var.domain_name_tags, var.tags)
}
resource "aws_cognito_user_pool" "default" {
  name = var.user_pool_name

  mfa_configuration          = var.mfa_enabled == true ? "ON" : "OFF"
  sms_authentication_message = var.sms_authentication_message

  # dynamic "sms_configuration" {
  #   for_each = var.mfa_enabled == true ? [1] : []
  #   content {
  #       external_id    = var.user_pool_name
  #       sns_caller_arn = aws_iam_role.example.arn
  #   }
  # }

  alias_attributes = var.alias_attributes


  dynamic "schema" {
      for_each = length(var.schema) > 0 ? var.schema : []
      content {
        name                     = schema.value.name
        attribute_data_type      = schema.value.attribute_data_type
        developer_only_attribute = false
        mutable                  = true
        required                 = schema.value.required
        string_attribute_constraints {
            min_length = schema.value.min_length
            max_length = schema.value.max_length
        }
      }
  }

  password_policy {
      minimum_length = var.min_password_length
      require_lowercase = true
      require_uppercase = true
      require_numbers = true
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }

    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  software_token_mfa_configuration {
    enabled = true
  }
  # lifecycle {
  #   prevent_destroy = true
  # }
  
  tags = var.global_tags
}
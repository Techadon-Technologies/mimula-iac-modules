variable "user_pool_name" {
  description = "user pool name"
  type = string
}

variable "mfa_enabled" {
  type = bool
  description = "cognito bool"
}

variable "alias_attributes" {
  type = list(string)
  description = "aliases" 
}

variable "sms_authentication_message" {
  type = string
  description = "sms_authentication_message"
}

variable "schema" {
  type = list(map(string))
  description = "cognito schema"
}

variable "min_password_length" {
  type = number
  description = "password length"
}
variable "global_tags" {
  type = object({
    Author      = string
    Environment = string
    Provisioner = string
    Region      = string
  })
  description = "base tags required in every resource"
}

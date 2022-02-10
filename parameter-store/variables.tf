variable "global_tags" {
  type = object({
    Author      = string
    Environment = string
    Provisioner = string
    Region      = string
  })
  description = "base tags required in every resource"
}

variable "parameters" {
  type = list(object({
    parameter_name = string
    parameter_type = string
    parameter_value = string
    parameter_description = string
  }))
  description = "ssm parameters"
}
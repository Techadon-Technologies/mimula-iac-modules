variable "global_tags" {
  type = object({
    Author      = string
    Environment = string
    Provisioner = string
    Region      = string
  })
  description = "base tags required in every resource"
}

variable "log_group_name" {
  type = string
  description = "log group name"
}

variable "retention_in_days" {
    type = number
    description = "logs retention time in days"
}
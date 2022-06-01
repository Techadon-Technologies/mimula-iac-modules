variable "name" {
  type = string
  description = "role & policy name"
}

variable "service_name" {
  type = string
  description = "service name"
}

variable "policies" {
  type = list(object({
      Effect = string
      Action = list(string)
      Resource = any
  }))
  description = "role policies"
}

variable "policies_attachment" {
  type = list(string)
  default = []
  description = "policies to attach list"
}
variable "tags" {
  type = object({
    Author      = string
    Environment = string
    Provisioner = string
    Region      = string
  })
  description = "base tags required in every resource"
}
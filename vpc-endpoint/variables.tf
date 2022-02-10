variable "vpc_id" {
  type        = string
  description = "vpc id to create vpc endpoint"
}

variable "region" {
  type        = string
  description = "vpc endpoint region"
}

variable "endpoint_enabled" {
  type = bool
  description = "endpoint enabling option"
}
variable "route_table_id" {
  type        = string
  description = "route_table_id associated with vpc endpoint"
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

variable "endpoint_sg_rules_egress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
  }))
  description = "list of egress rules for the security group"
  default = null
}

variable "endpoint_sg_rules_ingress" {
  type = any
  description = "list of ingress rules for the security group"
  default = null
}

variable "vpc_endpoint_type"{
  type = string
  description = "vpc endpoint type can be either Interface or Gateway"
}

variable "service_name" {
  type = string
  description = "service name for endpoint"
}

variable "private_dns_enabled" {
  type = bool
  description = "dns name for private interface endpoint"
  default = false
}

variable "subnet_ids" {
  type = list(string)
  description = "list of subnets to deploy eni"
  default = null
}
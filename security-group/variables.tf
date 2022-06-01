
variable "global_tags" {
  type = object({
    Author      = string
    Environment = string
    Provisioner = string
    Region      = string
    Name = string
    Usecase = string
  })
  description = "base tags required in every resource"
}

variable "sg_name" {
  type = string
  description = "security group name"
}

variable "sg_rules_egress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
  }))
  description = "list of egress rules for the security group"
}

variable "vpc_id" {
  type = string
  description = "vpc id for sg"
}
variable "sg_rules_ingress" {
  type = any
  description = "list of ingress rules for the security group"
}
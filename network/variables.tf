variable "aws_azs" {}
variable "az_count" {}
variable "vpc_instance_tenancy" {
  default = "default"
}
variable "project_name" {}
variable "vpc_enable_dns_support" {
  default = "true"
}
variable "vpc_enable_dns_hostnames" {
  default = "true"
}
variable "vpc_enable_classiclink" {
  default = "false"
}
variable "vpc_cidr_block"{
  default = ""
}
variable "global_tags" {
}
variable "default_sg_rules_ingress" {
  type= list(map(string))
  default = []  
}
variable "default_sg_rules_egress" {
  type= list(map(string))
  default = []  
}
variable "vpc_cidr_base" {}
variable "public_subnet_cidrs" {}
variable "private_subnet_cidrs" {}



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

variable "cluster_name" {
  type = string
  description = "cluster name"
}

variable "cluster_port" {
  type = number
  description = "cluster port"
}

variable "subnets" {
  type = list(string)
  description = "cache cluster subnets"
}

variable "cluster_engine" {
  type = string
  description = "cache cluster engine type"
}

variable "cluster_node_type" {
  type = string
  description = "cache cluster node type"
  default = "cache.t3.micro"
}

variable "cluster_engine_version" {
  type = string
  description = "cluster engine version"
}

variable "num_cache_nodes" {
  type = number
  description = "cluster cache nodes"
  default = 1
}

variable "parameter_group_name" {
  type = string
  description = "parameter group name"
}

variable "az_mode" {
  type = string
  default = "single-az"
}
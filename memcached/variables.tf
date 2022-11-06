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

variable "security_groups" {
  type = list(string)
  description = "cache cluster security groups"
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

variable "num_cache_nodes" {
  type = number
  description = "cluster cache nodes"
  default = 1
}

variable "parameter_group_name" {
  type = string
  description = "parameter group name"
}
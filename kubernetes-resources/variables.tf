variable "cluster_id" {
  type = string
  description = "eks cluster"
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

variable "service_accounts" {
  type = list(object({
    name = string
    namespace = string
  }))
  description = "list of service accounts for the cluster"
}

variable "namespaces" {
  type = list(object({
    name = string
  }))
  description = "list of namespaces for the cluster"
}

variable "storage_classes" {
  type = list(object({
    name = string
    provisioner = string
    reclaim_policy = string
    parameter_type = string
    parameter_encrypted = string
    mount_options = list(string)
  }))
}
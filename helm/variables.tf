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

variable "resources_list" {
  type = list(object({
    name = string
    repository = string
    chart = string
    timeout = string
    cleanup_on_fail = string
    for_update = string
    namespace = string
    set_list = list(object({
        name = string
        value = string
    }))
  }))
}
variable "tags" {
  type = object({
    Author      = string
    Environment = string
    Provisioner = string
    Region      = string
  })
  description = "base tags required in every resource"
}

variable "scan_images_on_push" {
  type = bool
  default = false
}

variable "encryption_configuration" {
  type = object({
    encryption_type = string
    kms_key         = string
  })
  description = "encryption config"
}

variable "image_tag_mutability" {
  type = string
  description = "images tag immutability"
}

variable "principals_full_access" {
  type        = list(string)
  description = "Principal ARNs to provide with full access to the ECR"
  default     = []
}

variable "principals_readonly_access" {
  type        = list(string)
  description = "Principal ARNs to provide with readonly access to the ECR"
  default     = []
}

variable "images_definition" {
  type = list(string)
  description = "images list"
}
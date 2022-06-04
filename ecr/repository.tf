# Tangent Solutions
# author LTM 

resource "aws_ecr_repository" "default" {
  count             = length(var.images_definition)
  name                 = var.images_definition[count.index]
  image_tag_mutability = var.image_tag_mutability

  encryption_configuration {
    encryption_type = var.encryption_configuration.encryption_type
    kms_key         = var.encryption_configuration.kms_key
  }

  image_scanning_configuration {
    scan_on_push = var.scan_images_on_push
  }

  tags = merge(
    var.tags,
    {
      "Name"      = "${var.images_definition[count.index]}"
    },
  )
}

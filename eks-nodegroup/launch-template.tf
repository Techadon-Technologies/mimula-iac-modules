locals {
  launch_template_version = length(var.launch_template_version) == 1 ? var.launch_template_version[0] : aws_launch_template.default.latest_version

}

resource "aws_launch_template" "default" {
  ebs_optimized = var.ebs_optimized

  # dynamic "block_device_mappings" {
  #   for_each = var.block_device_mappings

  #   content {
  #     device_name = block_device_mappings.value.device_name

  #     ebs {

  #       delete_on_termination = lookup(block_device_mappings.value, "delete_on_termination", null)
  #       encrypted             = lookup(block_device_mappings.value, "encrypted", null)
  #       iops                  = lookup(block_device_mappings.value, "iops", null)
  #       kms_key_id            = lookup(block_device_mappings.value, "kms_key_id", null)
  #       snapshot_id           = lookup(block_device_mappings.value, "snapshot_id", null)
  #       throughput            = lookup(block_device_mappings.value, "throughput", null)
  #       volume_size           = lookup(block_device_mappings.value, "volume_size", null)
  #       volume_type           = lookup(block_device_mappings.value, "volume_type", null)
  #     }
  #   }
  # }

  name_prefix            = var.cluster_name
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags          = merge(
      var.tags,
      {
        "Name" = "Launch Instances"
      }
    )
  }

  vpc_security_group_ids = var.associated_security_group_ids
  user_data              = local.userdata
  tags                   = local.node_group_tags

}
locals {

  features_require_ami = local.need_bootstrap
  need_ami_id          = local.features_require_ami && length(var.ami_image_id) == 0 ? false : true

  get_cluster_data = local.need_cluster_kubernetes_version || local.need_bootstrap || length(var.associated_security_group_ids) > 0 ? false : true

  autoscaler_enabled = var.cluster_autoscaler_enabled
  #
  # Set up tags for autoscaler and other resources
  #
  autoscaler_enabled_tags = {
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"             = "true"
  }
  autoscaler_kubernetes_label_tags = {
    for label, value in var.kubernetes_labels : format("k8s.io/cluster-autoscaler/node-template/label/%v", label) => value
  }
  autoscaler_kubernetes_taints_tags = {
    for taint in var.kubernetes_taints : format("k8s.io/cluster-autoscaler/node-template/taint/%v", taint.key) => taint.value
  }
  autoscaler_tags = merge(local.autoscaler_enabled_tags, local.autoscaler_kubernetes_label_tags, local.autoscaler_kubernetes_taints_tags)

  node_tags = merge(
    var.tags,
    {
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    }
  )
  node_group_tags = merge(local.node_tags, local.autoscaler_enabled ? local.autoscaler_tags : null)
}


data "aws_eks_cluster" "this" {
  count = local.get_cluster_data ? 1 : 0
  name  = var.cluster_name
}

resource "aws_eks_node_group" "default" {
  node_group_name = var.cluster_name

  # lifecycle {
  #   create_before_destroy = false
  #   ignore_changes        = [scaling_config[0].desired_size]
  # }

  # From here to end of resource should be identical in both node groups
  cluster_name    = var.cluster_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  instance_types  = var.instance_types
  ami_type        = var.ami_type
  release_version = try(var.ami_release_version[0], null)
  version         = try(var.kubernetes_version[0], null)

  tags = merge(
    var.tags,
    {
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    }
  )

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  launch_template {
    id      = aws_launch_template.default.id
    version = aws_launch_template.default.latest_version
  }

  dynamic "timeouts" {
    for_each = var.node_group_terraform_timeouts
    content {
      create = timeouts.value["create"]
      update = timeouts.value["update"]
      delete = timeouts.value["delete"]
    }
  }

  depends_on = [
    aws_launch_template.default
  ]
}

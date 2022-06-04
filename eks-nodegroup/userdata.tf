locals {
  userdata_vars = {
    before_cluster_joining_userdata = length(var.before_cluster_joining_userdata) == 0 ? "" : var.before_cluster_joining_userdata[0]
    bootstrap_extra_args            = length(var.bootstrap_additional_options) == 0 ? "" : var.bootstrap_additional_options[0]
    after_cluster_joining_userdata  = length(var.after_cluster_joining_userdata) == 0 ? "" : var.after_cluster_joining_userdata[0]
  }

  cluster_data = {
    cluster_endpoint           = local.get_cluster_data ? data.aws_eks_cluster.this[0].endpoint : null
    certificate_authority_data = local.get_cluster_data ? data.aws_eks_cluster.this[0].certificate_authority[0].data : null
    cluster_name               = local.get_cluster_data ? data.aws_eks_cluster.this[0].name : null
  }

  need_bootstrap = length(concat(
    var.bootstrap_additional_options, var.after_cluster_joining_userdata
  )) > 0 ? true : false

  # If var.userdata_override_base64[0] = "" then we explicitly set userdata to ""
  need_userdata = length(var.userdata_override_base64) == 0 ? (
  (length(var.before_cluster_joining_userdata) > 0) || local.need_bootstrap) : false

  userdata = local.need_userdata ? (
    base64encode(templatefile("${path.module}/userdata.tpl", merge(local.userdata_vars, local.cluster_data)))) : (
    try(var.userdata_override_base64[0], null)
  )
}
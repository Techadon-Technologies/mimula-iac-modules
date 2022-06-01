resource "kubernetes_config_map" "aws_auth_ignore_changes" {
  count      = var.apply_config_map_aws_auth && var.kubernetes_config_map_ignore_role_changes ? 1 : 0
  depends_on = [null_resource.wait_for_cluster[0]]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles    = yamlencode(distinct(concat(local.map_worker_roles, var.map_additional_iam_roles)))
    mapUsers    = yamlencode(var.map_additional_iam_users)
    mapAccounts = yamlencode(var.map_additional_aws_accounts)
  }

  lifecycle {
    ignore_changes = [data["mapRoles"]]
  }
}

resource "kubernetes_config_map" "aws_auth" {
  count      = var.apply_config_map_aws_auth && var.kubernetes_config_map_ignore_role_changes == false ? 1 : 0
  depends_on = [null_resource.wait_for_cluster[0]]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles    = replace(yamlencode(distinct(concat(local.map_worker_roles, var.map_additional_iam_roles))), "\"", local.yaml_quote)
    mapUsers    = replace(yamlencode(var.map_additional_iam_users), "\"", local.yaml_quote)
    mapAccounts = replace(yamlencode(var.map_additional_aws_accounts), "\"", local.yaml_quote)
  }
}
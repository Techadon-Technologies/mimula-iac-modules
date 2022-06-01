locals {
  yaml_quote = var.aws_auth_yaml_strip_quotes ? "" : "\""

  need_kubernetes_provider = var.apply_config_map_aws_auth

  kubeconfig_path_enabled = local.need_kubernetes_provider && var.kubeconfig_path_enabled
  kube_exec_auth_enabled  = local.kubeconfig_path_enabled ? false : local.need_kubernetes_provider && var.kube_exec_auth_enabled
  kube_data_auth_enabled  = local.kube_exec_auth_enabled ? false : local.need_kubernetes_provider && var.kube_data_auth_enabled

  exec_profile = local.kube_exec_auth_enabled && var.kube_exec_auth_aws_profile_enabled ? ["--profile", var.kube_exec_auth_aws_profile] : []
  exec_role    = local.kube_exec_auth_enabled && var.kube_exec_auth_role_arn_enabled ? ["--role-arn", var.kube_exec_auth_role_arn] : []

  certificate_authority_data_list          = coalescelist([aws_eks_cluster.default.certificate_authority], [[{ data : "" }]])
  certificate_authority_data_list_internal = local.certificate_authority_data_list[0]
  certificate_authority_data_map           = local.certificate_authority_data_list_internal[0]
  certificate_authority_data               = local.certificate_authority_data_map["data"]

  # Add worker nodes role ARNs (could be from many un-managed worker groups) to the ConfigMap
  # Note that we don't need to do this for managed Node Groups since EKS adds their roles to the ConfigMap automatically
  map_worker_roles = [
    for role_arn in var.workers_role_arns : {
      rolearn : role_arn
      username : "system:node:{{EC2PrivateDNSName}}"
      groups : [
        "system:bootstrappers",
        "system:nodes"
      ]
    }
  ]
}

resource "null_resource" "wait_for_cluster" {
  count      = var.apply_config_map_aws_auth ? 1 : 0
  depends_on = [aws_eks_cluster.default]

  provisioner "local-exec" {
    command     = var.wait_for_cluster_command
    interpreter = var.local_exec_interpreter
    environment = {
      ENDPOINT = aws_eks_cluster.default.endpoint
    }
  }
}


data "aws_eks_cluster_auth" "eks" {
  count = local.kube_data_auth_enabled ? 1 : 0
  name  = aws_eks_cluster.default.id
}


provider "kubernetes" {
  host                   = coalesce(aws_eks_cluster.default.endpoint, var.dummy_kubeapi_server)
  cluster_ca_certificate = base64decode(local.certificate_authority_data)
  token                  = local.kube_data_auth_enabled ? data.aws_eks_cluster_auth.eks[0].token : null
  config_path    = local.kubeconfig_path_enabled ? var.kubeconfig_path : ""
  config_context = var.kubeconfig_context

  dynamic "exec" {
    for_each = local.kube_exec_auth_enabled ? ["exec"] : []
    content {
      api_version = "client.authentication.k8s.io/v1alpha1"
      command     = "aws"
      args        = concat(local.exec_profile, ["eks", "get-token", "--cluster-name", aws_eks_cluster.default.id], local.exec_role)
    }
  }
}


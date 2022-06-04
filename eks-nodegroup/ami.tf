locals {
  # "amazon-eks-gpu-node-",
  arch_label_map = {
    "AL2_x86_64" : "",
    "AL2_x86_64_GPU" : "-gpu",
    "AL2_ARM_64" : "-arm64",
    "BOTTLEROCKET_x86_64" : "x86_64",
    "BOTTLEROCKET_ARM_64" : "aarch64"
  }

  ami_kind = split("_", var.ami_type)[0]

  ami_format = {
    "AL2" : "amazon-eks%s-node-%s"
    "BOTTLEROCKET" : "bottlerocket-aws-k8s-%s-%s-%s"
  }

  need_cluster_kubernetes_version = local.need_ami_id && length(var.kubernetes_version) == 0 ? true : false

  use_cluster_kubernetes_version = local.need_cluster_kubernetes_version && (local.ami_kind == "BOTTLEROCKET" || length(var.ami_release_version) == 0)

  ami_kubernetes_version = local.need_ami_id ? (local.use_cluster_kubernetes_version ? data.aws_eks_cluster.this[0].version :
    regex("^(\\d+\\.\\d+)", coalesce(local.ami_kind == "AL2" ? try(var.ami_release_version[0], null) : null, try(var.kubernetes_version[0], null)))[0]
  ) : ""

  # if ami_release_version is provided
  ami_version_regex = local.need_ami_id ? {
    "AL2" : (length(var.ami_release_version) == 1 ?
      replace(var.ami_release_version[0], "/^(\\d+\\.\\d+)\\.\\d+-(\\d+)$/", "$1-v$2") :
    "${local.ami_kubernetes_version}-*"),
    "BOTTLEROCKET" : (length(var.ami_release_version) == 1 ?
    format("v%s", var.ami_release_version[0]) : "*"),
  } : {}

  ami_regex = local.need_ami_id ? {
    "AL2" : format(local.ami_format["AL2"], local.arch_label_map[var.ami_type], local.ami_version_regex[local.ami_kind]),
    "BOTTLEROCKET" : format(local.ami_format["BOTTLEROCKET"], local.ami_kubernetes_version, local.arch_label_map[var.ami_type], local.ami_version_regex[local.ami_kind]),
  } : {}
}

data "aws_ami" "selected" {
  count = local.need_ami_id ? 1 : 0

  most_recent = true
  name_regex  = local.ami_regex[local.ami_kind]

  owners = ["amazon"]
}
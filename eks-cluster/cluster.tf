locals {
  cluster_encryption_config = {
    resources = var.cluster_encryption_config_resources

    provider_key_arn = var.cluster_encryption_config_enabled && var.cluster_encryption_config_kms_key_id == "" ? (
      aws_kms_key.cluster.arn
    ) : var.cluster_encryption_config_kms_key_id
  }

}

resource "aws_kms_key" "cluster" {
  description             = "EKS Cluster ${var.name} Encryption Config KMS Key"
  enable_key_rotation     = var.cluster_encryption_config_kms_key_enable_key_rotation
  deletion_window_in_days = var.cluster_encryption_config_kms_key_deletion_window_in_days
  policy                  = var.cluster_encryption_config_kms_key_policy
  tags                    = var.tags
}

resource "aws_kms_alias" "cluster" {
  name          = format("alias/%v", var.name)
  target_key_id = aws_kms_key.cluster.key_id
}

resource "aws_eks_cluster" "default" {
  name                      = var.name
  tags                      = merge(
    var.tags,
    {
      "Name" = "eks-cluster"
    }
  )
  role_arn                  = var.eks_cluster_service_role_arn
  version                   = var.kubernetes_version
  enabled_cluster_log_types = var.enabled_cluster_log_types

  dynamic "encryption_config" {
    for_each = var.cluster_encryption_config_enabled ? [local.cluster_encryption_config] : []
    content {
      resources = lookup(encryption_config.value, "resources")
      provider {
        key_arn = lookup(encryption_config.value, "provider_key_arn")
      }
    }
  }

  vpc_config {
    security_group_ids      = var.security_group_ids
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
  }

}

data "tls_certificate" "cluster" {
  url   = aws_eks_cluster.default.identity.0.oidc.0.issuer
}

resource "aws_iam_openid_connect_provider" "default" {
  url   = aws_eks_cluster.default.identity.0.oidc.0.issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.cluster.certificates.0.sha1_fingerprint]
}

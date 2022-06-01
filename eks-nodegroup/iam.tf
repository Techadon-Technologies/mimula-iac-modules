locals {
  create_role           = length(var.node_role_arn) == 0
  aws_policy_prefix     = local.create_role ? format("arn:%s:iam::aws:policy", join("", data.aws_partition.current.*.partition)) : ""
  node_role_policy_arns = sort(var.node_role_policy_arns)
}

data "aws_partition" "current" {
  count = 1
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "default" {
  name                 = var.cluster_name
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  permissions_boundary = var.node_role_permissions_boundary
  tags                 = var.tags
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = format("%s/%s", local.aws_policy_prefix, "AmazonEKSWorkerNodePolicy")
  role       = aws_iam_role.default.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = format("%s/%s", local.aws_policy_prefix, "AmazonEKS_CNI_Policy")
  role       = aws_iam_role.default.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = format("%s/%s", local.aws_policy_prefix, "AmazonEC2ContainerRegistryReadOnly")
  role       = aws_iam_role.default.name
}

resource "aws_iam_role_policy_attachment" "existing_policies_for_eks_workers_role" {
  policy_arn = local.node_role_policy_arns[count.index]
  role       = aws_iam_role.default.name
}
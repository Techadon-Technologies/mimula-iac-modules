data "aws_eks_cluster" "cluster" {
  name = var.cluster_id
}

data "terraform_remote_state" "eks" {
  backend = "remote"
  config = {
    bucket  = var.tfstate_bucket
    key     = var.tfstate_key
    region  = var.tags.Region
  }
}
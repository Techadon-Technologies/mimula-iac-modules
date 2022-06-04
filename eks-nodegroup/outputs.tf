
output "eks_node_group_id" {
  description = "EKS Cluster name and EKS Node Group name separated by a colon"
  value       = aws_eks_node_group.default.id
}

output "eks_node_group_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Node Group"
  value       = aws_eks_node_group.default.arn
}

output "eks_node_group_resources" {
  description = "List of objects containing information about underlying resources of the EKS Node Group"
  value       = aws_eks_node_group.default.resources
}

output "eks_node_group_status" {
  description = "Status of the EKS Node Group"
  value       = aws_eks_node_group.default.status
}

output "eks_node_group_launch_template_name" {
  description = "The name of the launch template used for this node group"
  value       = aws_launch_template.default.name
}
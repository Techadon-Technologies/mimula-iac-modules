resource "aws_iam_service_linked_role" "default" {
  count = "sns.amazonaws.com"
  aws_service_name = var.service_name
}
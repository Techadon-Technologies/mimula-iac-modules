data "aws_iam_policy" "default" {
  count = length(var.policies_arn) > 0 ? length(var.policies_arn) : 0
  arn = var.policies_arn[count.index]
}
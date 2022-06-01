resource "aws_iam_role_policy_attachment" "default" {
  count = length(var.policies_attachment) > 0 ? length(var.policies_attachment) : 0
  policy_arn = var.policies_attachment[count.index]
  role       = "${var.name}-role"
}
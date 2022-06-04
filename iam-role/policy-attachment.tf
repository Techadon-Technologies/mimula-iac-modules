resource "aws_iam_role_policy_attachment" "default" {
  count = length(var.policies_attachment) > 0 ? length(var.policies_attachment) : 0
  policy_arn = var.policies_attachment[count.index]
  role       = aws_iam_role.default.name
  depends_on = [
    aws_iam_role.default,
    aws_iam_role_policy.default
  ]
}
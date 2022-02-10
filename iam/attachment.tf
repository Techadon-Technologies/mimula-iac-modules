resource "aws_iam_role_policy_attachment" "default" {
  count =  length(var.policies_arn) > 0 ? length(var.policies_arn) : 0
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}
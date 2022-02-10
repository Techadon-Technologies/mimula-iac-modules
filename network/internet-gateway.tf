# Mimula
# author LTM 

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = merge(
    var.global_tags,
    {
      "Name" = "${var.project_name} Internet Gateway"
    },
  )
  depends_on = [
    aws_vpc.default,
  ]
}
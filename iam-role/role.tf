resource "aws_iam_role" "default" {
  name = "${var.name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "${var.service_name}"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

tags = merge(
    var.tags,
    {
        "Name" = "${var.name}-role"
    }
)
}

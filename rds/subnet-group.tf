resource "aws_db_subnet_group" "default" {
  name       = "${var.project_name}_subnet_group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}
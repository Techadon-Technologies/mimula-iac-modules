resource "aws_s3_bucket_public_access_block" "default" {
  count = var.make_whole_bucket_public ? 1 : 0
  bucket = aws_s3_bucket.default.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
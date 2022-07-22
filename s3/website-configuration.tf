resource "aws_s3_bucket_website_configuration" "default" {
  count = var.iswebsite == true ? 1 : 0
  bucket = aws_s3_bucket.default.bucket

  index_document {
    suffix = var.website_configuration.index_document
  }

  error_document {
    key = var.website_configuration.error_document
  }

}
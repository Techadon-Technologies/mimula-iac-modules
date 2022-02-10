resource "aws_s3_bucket_metric" "default" {
  count  = var.bucket_metrics_enabled == true ? 1 : 0
  bucket = aws_s3_bucket.default.bucket
  name   = "${var.bucket_name}-bucket-metric"
}
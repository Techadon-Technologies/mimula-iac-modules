resource "aws_s3_bucket_object" "default" {
    count = length(var.prefixes) > 0 ? length(var.prefixes) : 0
    bucket = "${aws_s3_bucket.default.id}"
    acl    = "private"
    key    = var.prefixes[count.index]
    server_side_encryption = var.sse_algorithm
    content_type = "application/x-directory"
}
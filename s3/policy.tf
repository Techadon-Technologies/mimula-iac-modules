

data "aws_iam_policy_document" "bucket_policy" {

  dynamic "statement" {
    for_each = var.disallow_non_encrypted_uploads ? [1] : []

    content {
      sid       = "DenyIncorrectEncryptionHeader"
      effect    = "Deny"
      actions   = ["s3:PutObject"]
      resources = ["${aws_s3_bucket.default.arn}/*"]

      principals {
        identifiers = ["*"]
        type        = "*"
      }

      condition {
        test     = "StringNotEquals"
        values   = [var.sse_algorithm]
        variable = "s3:x-amz-server-side-encryption"
      }
    }
  }

  dynamic "statement" {
    for_each = var.disallow_non_encrypted_uploads ? [1] : []

    content {
      sid       = "DenyUnEncryptedObjectUploads"
      effect    = "Deny"
      actions   = ["s3:PutObject"]
      resources = ["${aws_s3_bucket.default.arn}/*"]

      principals {
        identifiers = ["*"]
        type        = "*"
      }

      condition {
        test     = "Null"
        values   = ["true"]
        variable = "s3:x-amz-server-side-encryption"
      }
    }
  }

  dynamic "statement" {
    for_each = var.disallow_non_ssl_requests ? [1] : []

    content {
      sid       = "ForceSSLOnlyAccess"
      effect    = "Deny"
      actions   = ["s3:*"]
      resources = [aws_s3_bucket.default.arn, "${aws_s3_bucket.default.arn}/*"]

      principals {
        identifiers = ["*"]
        type        = "*"
      }

      condition {
        test     = "Bool"
        values   = ["false"]
        variable = "aws:SecureTransport"
      }
    }
  }

  dynamic "statement" {
    for_each = length(var.s3_cross_account_replication_source_roles) > 0 ? [1] : []

    content {
      sid = "CrossAccountReplicationObjects"
      actions = [
        "s3:ReplicateObject",
        "s3:ReplicateDelete",
        "s3:ReplicateTags",
        "s3:GetObjectVersionTagging",
        "s3:ObjectOwnerOverrideToBucketOwner"
      ]
      resources = ["${aws_s3_bucket.default.arn}/*"]
      principals {
        type        = "AWS"
        identifiers = var.s3_cross_account_replication_source_roles
      }
    }
  }

  dynamic "statement" {
    for_each = length(var.s3_cross_account_replication_source_roles) > 0 ? [1] : []

    content {
      sid       = "CrossAccountReplicationBucket"
      actions   = ["s3:List*", "s3:GetBucketVersioning", "s3:PutBucketVersioning"]
      resources = [aws_s3_bucket.default.arn]
      principals {
        type        = "AWS"
        identifiers = var.s3_cross_account_replication_source_roles
      }
    }
  }

}

data "aws_iam_policy_document" "aggregated_policy" {
  source_json   = var.policy
  override_json = data.aws_iam_policy_document.bucket_policy.json
}

resource "aws_s3_bucket_policy" "default" {
  bucket     = aws_s3_bucket.default.id
  policy     = data.aws_iam_policy_document.aggregated_policy.json
  depends_on = [aws_s3_bucket_public_access_block.default]
}
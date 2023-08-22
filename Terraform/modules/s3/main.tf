resource "aws_s3_bucket" "registry_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "registry_access" {
  bucket = aws_s3_bucket.registry_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}


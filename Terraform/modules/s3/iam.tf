resource "aws_iam_policy" "registry_bucket_policy" {
  name        = "registry_bucket_policy"
  path        = "/"
  description = "Allows access to registry_bucket for nodes"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListMultipartUploadParts",
        "s3:AbortMultipartUpload"
        ],
        "Resource" : "arn:aws:s3:::${var.s3_bucket_name}/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:ListBucketMultipartUploads"
        ],
        "Resource" : "arn:aws:s3:::${var.s3_bucket_name}"
      }
    ]
  })
}

resource "aws_iam_role" "registry_bucket_role" {
  name = "registry_bucket_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "registry_bucket_policy_attachment" {
  policy_arn = aws_iam_policy.registry_bucket_policy.arn
  role       = aws_iam_role.registry_bucket_role.name
}

resource "aws_iam_instance_profile" "registry_iam_profile" {
  name = "registry_iam_profile"
  role = aws_iam_role.registry_bucket_role.name
}

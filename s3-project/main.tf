provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "restricted_bucket" {
  bucket = "only-ec2-write-bucket-123456" # Must be globally unique
}

resource "aws_s3_bucket_policy" "restrict_write" {
  bucket = aws_s3_bucket.restricted_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement: [{
      Effect = "Allow",
      Principal = {
        AWS = data.terraform_remote_state.ec2.outputs.ec2_role_arn
      },
      Action = "s3:PutObject",
      Resource = "${aws_s3_bucket.restricted_bucket.arn}/*"
    }]
  })
}

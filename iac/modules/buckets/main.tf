resource "aws_s3_bucket" "s3_bucket_src" {
  depends_on = [ aws_s3_bucket.s3_bucket_dest ]

  bucket = "${var.bucket_prefix}-names"

  force_destroy = true

  tags = {
    Name = "${var.bucket_prefix}-names"
  }
}

resource "aws_s3_bucket" "s3_bucket_dest" {
  bucket = "${var.bucket_prefix}-names-emails"

  force_destroy = true

  tags = {
    Name = "${var.bucket_prefix}-names-emails"
  }
}

resource "aws_s3_bucket" "s3_bucket_app" {
  bucket = "${var.bucket_prefix}-app"

  force_destroy = true

  tags = {
    Name = "${var.bucket_prefix}-app"
  }
}
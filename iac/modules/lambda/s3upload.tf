resource "aws_s3_object" "layer" {
  bucket = var.bucket_app
  key    = "layer"
  source = "${path.module}/zips/email_generator_layer.zip"
}

resource "aws_s3_object" "func" {
  bucket = var.bucket_app
  key    = "func"
  source = "${path.module}/zips/email_generator_func.zip"
}
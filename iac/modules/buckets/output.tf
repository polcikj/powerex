output "s3_bucket_src_name" {
  value = resource.aws_s3_bucket.s3_bucket_src.id
}

output "s3_bucket_app_name" {
  value = resource.aws_s3_bucket.s3_bucket_app.id
}

output "s3_bucket_src_arn" {
  value = resource.aws_s3_bucket.s3_bucket_src.arn
}
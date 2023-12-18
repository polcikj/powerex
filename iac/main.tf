module "aws_github" {
  source     = "./modules/aws_github"
  region     = var.region
  repository = var.repository
}

module "buckets" {
  source        = "./modules/buckets"
  region        = var.region
  bucket_prefix = var.bucket_prefix
}

module "lambda" {
  source         = "./modules/lambda"
  region         = var.region
  bucket_app     = module.buckets.s3_bucket_app_name
  bucket_src     = module.buckets.s3_bucket_src_name
  bucket_src_arn = module.buckets.s3_bucket_src_arn
}

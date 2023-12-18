module "lambda_layer_s3" {
  source = "terraform-aws-modules/lambda/aws"

  depends_on = [resource.aws_s3_object.layer]

  create_layer = true

  layer_name               = "email-generator-lambda-layer-s3"
  description              = "Email Generator Lambda Layer (deployed from S3)"
  compatible_runtimes      = ["python3.11"]
  compatible_architectures = ["arm64"]

  create_package = false

  s3_existing_package = {
    bucket = var.bucket_app
    key    = "layer"
  }
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  depends_on = [resource.aws_s3_object.func]

  function_name = "email-generator-lambda-function-s3"
  description   = "Email Generator Lambda Function (deployed from S3)"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  architectures = ["arm64"]
  publish       = true

  s3_existing_package = {
    bucket = var.bucket_app
    key    = "func"
  }

  layers = [
    module.lambda_layer_s3.lambda_layer_arn,
  ]

  create_role    = false
  create_package = false

  lambda_role = resource.aws_iam_role.lambda_role.arn
}

resource "aws_lambda_permission" "s3_trigger_permission" {
  statement_id  = "AllowS3Invocation"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.lambda_function_name
  principal     = "s3.amazonaws.com"

  source_arn = var.bucket_src_arn
}

resource "aws_s3_bucket_notification" "lambda_s3_trigger" {
  bucket = var.bucket_src

  lambda_function {
    lambda_function_arn = module.lambda_function.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".txt"
  }
}

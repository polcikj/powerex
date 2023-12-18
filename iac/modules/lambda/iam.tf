resource "aws_iam_policy" "lambda_policy" {
  name   = "lambda-policy"
  policy = templatefile("${path.module}/policy/lambda.tftpl", { bucket_src = "${var.bucket_src}", bucket_src_emails = "${var.bucket_src}-emails" })
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

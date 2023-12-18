module "github-oidc" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "2.1.0"

  create_oidc_provider = true
  create_oidc_role     = true
  role_name            = "aws-github-role"

  repositories = [var.repository]
  oidc_role_attach_policies = [
    # "arn:aws:iam::aws:policy/AdministratorAccess"
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ]
}
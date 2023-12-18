# PowereX Email Generator

This is a serverless app which generates email addresses from names.

Example Input

```
Ethan Mitchell
Olivia Williams
Liam Anderson
```

Example Output

```
ethan.mitchell@powerex.io
olivia.williams@powerex.io
liam.anderson@powerex.io
```

## How does it work?

Go to the Github Actions. There are 3 pipelines.

### 1. Deploy

Before the deployment you need to run initial setup.

#### 1.a Github Requirements

Go to the Repo Settings -> Secrets and variables and customise vars for your AWS account.

#### 1.b AWS Requirements

Go to the ./iac/env/dev.hcl and set up an S3 bucket for TF state and AWS region.

With the admin access permissions, go to the AWS console and manually create the S3 bucket with the name you provided in the ./iac/env/dev.hcl file.

#### 1.c Terraform Requirements

First, you need to create AWS Github role as an AWS admin.

In your local terminal, make sure you have these ENV AWS vars filled with admin access credentials.

```
env | grep -i aws
AWS_ACCESS_KEY_ID=aaa..
AWS_SECRET_ACCESS_KEY=bbb...
AWS_REGION=eu-central-1
```

In your local terminal, go to the .iac dir and setup the access role for the Github pipeline.

```
terraform init -reconfigure -backend-config=env/dev.hcl
terraform apply -target=module.aws_github -var-file=env/dev.tfvars
```

#### 1.d Github can run the pipeline.

Now, click Run workflow to create the app from scratch.

After 1 min. your app should be ready.

### 2. Generate Emails

The pipeline uploads 2 test files to the S3 bucket starting with the name <BUCKET_PREFIX> var.

```
./app/test/names1.txt
./app/test/names2.txt
```

and then downloads 2 files with the generated email addresses from the names.
The files can be downloaed as generated_emails.zip archive in the workflow detail.

### 3. Undeploy

Run this pipeline to completely destroy the app.

#### 3.a Terraform Cleanup

In your local terminal, go to the .iac dir and DESTROY the access role for the Github pipeline.

```
terraform init -reconfigure -backend-config=env/dev.hcl
terraform destroy -target=module.aws_github -var-file=env/dev.tfvars
```

## Test Locally

Run, if you want to test code of the Lambda function.

### Python Packages

Make sure, your Python version is 3.11 or higher.

```
./ = repo_root
```

```
mkdir -p ./iac/modules/lambda/zips/
cd ./app
python3 setup.py sdist
```

```
pip3 install --no-cache-dir \
  --platform manylinux2014_arm64 \
  --target=../python \
  --implementation cp \
  --python-version 3.11 \
  --only-binary=:all: --upgrade \
  -r requirements.txt
```

```
pip3 install .
```

```
cd ./app/test
python3 test1.py
python3 test2.py
```

```
cat emails_from_names1.txt
cat emails_from_names2.txt
```

### Lambda Packages

In AWS console, create a Lambda layer and a Lambda function from the .zip files.

```
cd ./
zip -r ./iac/modules/lambda/zips/email_generator_layer.zip python
```

```
cd ./app
zip ../iac/modules/lambda/zips/email_generator_func.zip lambda_function.py
```

```
cd ./
ls -l ./iac/modules/lambda/zips/
```

Then, create 2 buckets:

- 'BUCKET_NAME' as a source bucket and create a lambda trigger for s3 upload for this bucket.
- 'BUCKET_NAME-emails' as destination bucket.

Upload 2 test file from ./app/test to the source S3 bucket a download your generated files from the destination S3 bucket.

## Resources

```
https://docs.aws.amazon.com/lambda/
```

```
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
```

```
https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest
```

```
https://registry.terraform.io/modules/terraform-module/github-oidc-provider/aws/latest
```

```
https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
```

```
https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners/about-github-hosted-runners
```

```
https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners/customizing-github-hosted-runners
```
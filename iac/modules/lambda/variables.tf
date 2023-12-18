variable "region" {
  description = "AWS Region"
  type        = string
}

variable "module_name" {
  default = "lambda"
  type    = string
}

variable "bucket_app" {
  type = string
}

variable "bucket_src_arn" {
  type = string
}

variable "bucket_src" {
  type = string
}

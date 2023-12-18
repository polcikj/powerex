variable "region" {
  description = "AWS Region"
  type        = string
}

variable "module_name" {
  default = "buckets"
  type    = string
}

variable "bucket_prefix" {
  type = string
}

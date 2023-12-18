variable "region" {
  description = "AWS Region"
  type        = string
}

variable "repository" {
  description = "Repository"
  type        = string
}

variable "bucket_prefix" {
  description = "Bucket Name must be unique, that's why a prefix is required"
  type = string
}

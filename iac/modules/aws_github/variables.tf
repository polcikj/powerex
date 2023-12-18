variable "region" {
  description = "AWS Region"
  type        = string
}

variable "repository" {
  description = "Repository"
  type        = string
}

variable "module_name" {
  default = "aws_github"
  type    = string
}

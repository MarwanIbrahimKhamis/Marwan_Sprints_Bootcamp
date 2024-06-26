variable "region" {
 description = "AWS region"
 type = string
 default = "us-east-1"
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "access_ip" {
  type = string
}


variable "ecr" {
 description = "Repository name"
 type = string
}
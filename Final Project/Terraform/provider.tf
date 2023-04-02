terraform {
 required_providers {
     aws = {
         source = "hashicorp/aws"
         version = "~>4.19.0"
     }
 }
}

provider "aws" {
 region = var.region
 access_key = var.aws_access_key
 secret_key = var.aws_secret_key
 #access_key = "my-access-key"
 #secret_key = "my-secret-key"
 # use your credentials from file .aws/credentials
}
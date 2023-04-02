variable "ami" {
  type    = string
  default = "ami-0557a15b87f6559cf"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "jenkins-key-pair"
}

variable "subnet_id" {
  type    = string
}

variable "instance_name" {
  type    = string
  default = "Jenkins-ec2-instance"
}

variable "public_sg" {}
variable "public_subnet" {}
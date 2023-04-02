module "network" {
  source          = "./network"
  access_ip       = var.access_ip
  vpc_cidr        = local.vpc_cidr
  security_groups = local.security_groups
}

module "ec2" {
  source        = "./ec2"
  public_sg     = module.network.public_sg
  public_subnet = module.network.public_subnet
}

module "ecr" {
  source = "./ecr"
  region = var.region
  name = var.ecr
}
#module "ec2" {
#  source = "./ec2"
#
#  region        = "us-west-2"
#  ami           = "ami-0123456789abcdef0"
#  instance_type = "t2.micro"
#  key_name      = "my-key-pair"
#  subnet_id     = "subnet-0987654321"
#  instance_name = "my-ec2-instance"
#}

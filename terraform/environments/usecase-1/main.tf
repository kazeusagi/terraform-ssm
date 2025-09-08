module "vpc" {
  source    = "../../modules/vpc"
  name      = "usecase-1"
  allow_ssh = true
}

module "ec2" {
  source            = "../../modules/ec2"
  name              = "usecase-1"
  ami_id            = "ami-07faa35bbd2230d90" # Amazon Linux 2023 x86_64
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.subnet_id
  security_group_id = module.vpc.security_group_id
  enable_ssh        = true
  enable_ssm        = true
}

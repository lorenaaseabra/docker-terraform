provider "aws" {
  region = "ca-central-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source           = "./modules/alb"
  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group   = module.security_groups.alb_sg
}

module "ec2" {
  source             = "./modules/ec2"
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.vpc.public_subnet_ids[0]
  private_subnet_ids = module.vpc.private_subnet_ids
  security_groups    = {
    public_ec2_sg  = module.security_groups.public_ec2_sg
    private_ec2_sg = module.security_groups.private_ec2_sg
  }
  asg_target_group = module.alb.alb_target_group
}

module "rds" {
  source          = "./modules/rds"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnet_ids
  security_group  = module.security_groups.rds_sg
}

terraform {
  required_version = "1.6.3"
  backend "s3" {
    bucket = "kaku-tfstate"
    key    = "kaku-infrastructure/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "network" {
  source = "./module/network"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group
}

module "security-group" {
  source = "./module/security-group"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group

  vpc_id = module.network.vpc_id
}

module "alb" {
  source = "./module/alb"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group

  vpc_id = module.network.vpc_id
  subnet_ingress_1_id = module.network.public_subnet_ingress_1_id
  subnet_ingress_2_id = module.network.public_subnet_ingress_2_id
  sg_alb_id = module.security-group.sg_alb_id
}

module "rds" {
  source = "./module/rds"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group

  vpc_id = module.network.vpc_id
  subnet_mysql_1_id = module.network.private_subnet_mysql_1_id
  subnet_mysql_2_id = module.network.private_subnet_mysql_2_id
  sg_mysql_id = module.security-group.sg_mysql_id
}

# module "vpc-endpoint" {
#   source = "./module/vpc-endpoint"

#   name_prefix = var.name_prefix
#   tag_name = var.tag_name
#   tag_group = var.tag_group

#   vpc_id = module.network.vpc_id
#   subnet_vpc_endpoint_1_id = module.network.private_subnet_vpc_endpoint_1_id
#   subnet_vpc_endpoint_2_id = module.network.private_subnet_vpc_endpoint_2_id
#   sg_vpc_endpoint_id = module.security-group.sg_vpc_endpoint_id
#   route_nodejs_id = module.network.route_nodejs_id
#   route_puma_id = module.network.route_puma_id
# }

module "ecr" {
  source = "./module/ecr"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group
}

module "cloud-watch-logs" {
  source = "./module/cloud-watch-logs"

  name_prefix = var.name_prefix
}

module "iam" {
  source = "./module/iam"

  name_prefix = var.name_prefix
}

module "route53" {
  source = "./module/route53"

  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
}
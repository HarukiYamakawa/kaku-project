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

  certificate_arn = data.aws_acm_certificate.default.arn
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

module "vpc-endpoint" {
  source = "./module/vpc-endpoint"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group

  vpc_id = module.network.vpc_id
  subnet_vpc_endpoint_1_id = module.network.private_subnet_vpc_endpoint_1_id
  subnet_vpc_endpoint_2_id = module.network.private_subnet_vpc_endpoint_2_id
  sg_vpc_endpoint_id = module.security-group.sg_vpc_endpoint_id
  route_nodejs_id = module.network.route_nodejs_id
  route_puma_id = module.network.route_puma_id
}

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
  domain_name = data.aws_ssm_parameter.domain_name.value
  domain_zone_id = data.aws_route53_zone.default.zone_id

  vpc_id = module.network.vpc_id
  service_discovery_domain_name = var.service_discovery_domain_name
  service_discovery_sub_domain_name = var.service_discovery_sub_domain_name
}

module "ecs" {
  source = "./module/ecs"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group

  vpc_id = module.network.vpc_id
  subnet_puma_1_id = module.network.private_subnet_puma_1_id
  subnet_puma_2_id = module.network.private_subnet_puma_2_id
  subnet_node_1_id = module.network.private_subnet_nodejs_1_id
  subnet_node_2_id = module.network.private_subnet_nodejs_2_id

  primary_db_host = module.rds.primary_db_host
  db_name = module.rds.db_name

  db_secret_username = "${data.aws_secretsmanager_secret_version.db_secret_id.arn}:username::"
  db_secret_password = "${data.aws_secretsmanager_secret_version.db_secret_id.arn}:password::"

  domain_name = data.aws_ssm_parameter.domain_name.value

  #pumaのタスク定義用
  sg_puma_id = module.security-group.sg_puma_id
  image_puma = module.ecr.puma_repository
  image_puma_version = var.image_puma_version
  execution_role_arn = module.iam.ecs_task_execution_role_arn
  task_role_arn = module.iam.ecs_task_role_arn
  cloudwatch_log_group_arn_puma = module.cloud-watch-logs.puma_log_group
  tg_puma_arn = module.alb.tg_puma_arn
  task_cpu_puma = var.task_cpu_puma
  task_memory_puma = var.task_memory_puma
  task_container_memory_reservation_puma = var.task_container_memory_reservation_puma
  task_container_memory_puma = var.task_container_memory_puma
  task_container_cpu_puma = var.task_container_cpu_puma
  task_count_puma = var.task_count_puma
  task_health_check_grace_period_seconds_puma = var.task_health_check_grace_period_seconds_puma
  service_discovery_arn = module.route53.service_discovery_arn

  #nodejsのタスク定義用
  sg_nodejs_id = module.security-group.sg_nodejs_id
  image_nodejs = module.ecr.nodejs_repository
  image_nodejs_version = var.image_nodejs_version
  cloudwatch_log_group_arn_nodejs = module.cloud-watch-logs.nodejs_log_group
  tg_nodejs_arn = module.alb.tg_nodejs_arn
  task_cpu_nodejs = var.task_cpu_nodejs
  task_memory_nodejs = var.task_memory_nodejs
  task_container_memory_reservation_nodejs = var.task_container_memory_reservation_nodejs
  task_container_memory_nodejs = var.task_container_memory_nodejs
  task_container_cpu_nodejs = var.task_container_cpu_nodejs
  task_count_nodejs = var.task_count_nodejs
  task_health_check_grace_period_seconds_nodejs = var.task_health_check_grace_period_seconds_nodejs
  public_rails_api_url = data.aws_ssm_parameter.next_public_rails_api_url.value
  private_rails_api_url = data.aws_ssm_parameter.next_private_rails_api_url.value
}

module "s3" {
  source = "./module/s3"

  name_prefix = var.name_prefix
  tag_name = var.tag_name
  tag_group = var.tag_group
}
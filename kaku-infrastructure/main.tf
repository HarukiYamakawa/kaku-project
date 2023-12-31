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

terraform {
  backend "s3" {
    bucket         = "tf-state-bucket-fz"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "network" {
  source = "../../modules/network"
  env    = "prod"

  vpc_cidr           = "10.2.0.0/16"
  availability_zones = ["ap-south-1a", "ap-south-1b"]
  public_subnets     = ["10.2.1.0/24", "10.2.8.0/24"]
  private_subnets    = ["10.2.9.0/24", "10.2.10.0/24"]
}

module "ecr" {
  source = "../../modules/ecr"
  env    = "prod"
}

module "ecs" {
  source = "../../modules/ecs"
  env    = "prod"
}

module "iam" {
  source = "../../modules/iam"
  env    = "prod"
}

module "alb" {
  source         = "../../modules/alb"
  env            = "prod"
  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets
}

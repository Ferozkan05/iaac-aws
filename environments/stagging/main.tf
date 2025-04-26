terraform {
  backend "s3" {
    bucket         = "tf-state-bucket-fz"
    key            = "stage/terraform.tfstate"
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
  env    = "stage"

  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["ap-south-1a", "ap-south-1b"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "ecr" {
  source = "../../modules/ecr"
  env    = "stage"
}

module "ecs" {
  source = "../../modules/ecs"
  env    = "stage"
}

module "iam" {
  source = "../../modules/iam"
  env    = "stage"
}

module "alb" {
  source         = "../../modules/alb"
  env            = "stage"
  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets
}

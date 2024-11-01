terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source              = "./modules/vpc"
  cidr_block          = "10.0.0.0/16"
  vpc_name            = "my-vpc"
  public_subnet_cidr = "10.0.1.0/24"
  public_subnet_az   = "eu-west-1a"
  private_subnet_cidr = "10.0.2.0/24"
  private_subnet_az   = "eu-west-1a"
}

module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source           = "./modules/eks"
  cluster_name     = "my-eks-cluster"
  cluster_role_arn = module.iam.eks_cluster_role_arn
  node_group_name  = "my-node-group"
  node_role_arn    = module.iam.eks_node_role_arn
  subnet_ids       = [module.vpc.private_subnet_id]
  desired_size     = 1
  max_size         = 1
  min_size         = 1
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_version" {
  value = module.eks.cluster_version
}

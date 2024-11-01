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
  source                       = "./modules/vpc"
  cidr_block                   = "10.0.0.0/16"
  vpc_name                     = "my-vpc"
  private_subnet_cidr_1        = "10.0.2.0/24"
  private_subnet_az_1          = "eu-west-1a"
  private_subnet_cidr_2        = "10.0.3.0/24"
  private_subnet_az_2          = "eu-west-1b"  # Ensure this is a different AZ
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
  subnet_ids       = [
    module.vpc.private_subnet_id,
    module.vpc.private_subnet_2_id  # Add the second subnet ID here
  ]
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

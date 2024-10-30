provider "aws" {
  region = var.region
}

resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "eks_vpc"
  }
}

resource "aws_subnet" "eks_subnet" {
  count = 2
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
}

data "aws_availability_zones" "available" {}
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks_cluster_name
  cluster_version = "1.22"
  subnet_ids        = aws_subnet.eks_subnet[*].id
  vpc_id          = aws_vpc.eks_vpc.id

  node_groups = {
    eks_nodes = {
      desired_capacity = var.desired_capacity
      max_capacity     = var.max_size
      min_capacity     = var.min_size
      instance_type    = var.instance_type
      key_name         = "my-key-pair" # Replace with your key pair name for SSH access
    }
  }

  tags = {
    Environment = "production"
  }
}

variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "eks_cluster_name" {
  description = "Name of the EKS Cluster"
  default     = "my-eks-cluster"
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  default     = "my-eks-node-group"
}

variable "instance_type" {
  description = "EC2 instance type for the nodes"
  default     = "t3.micro"
}

variable "desired_capacity" {
  description = "Desired number of nodes"
  default     = 2
}

variable "max_size" {
  description = "Maximum number of nodes in the Auto Scaling group"
  default     = 5
}

variable "min_size" {
  description = "Minimum number of nodes in the Auto Scaling group"
  default     = 1
}
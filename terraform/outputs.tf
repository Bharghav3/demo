output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_security_group" {
  value = aws_security_group.eks_cluster_sg.id
}

output "node_group_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

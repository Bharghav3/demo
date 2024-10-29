resource "aws_security_group" "eks_cluster_sg" {
  vpc_id = aws_vpc.eks_vpc.id
  description = "EKS Cluster security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "eks_node_sg" {
  vpc_id = aws_vpc.eks_vpc.id
  description = "EKS Node security group"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.eks_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "eks_cluster" {
  name        = "${local.project}-eks-cluster"
  description = "Security group for calculator production EKS cluster"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.project}-eks-cluster-sg"
  }
}

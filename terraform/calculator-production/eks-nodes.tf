resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "calculator-app-ng"
  node_role_arn   = aws_iam_role.eks_node.arn

  subnet_ids = aws_subnet.public[*].id

  instance_types = ["t3.small"]

  ami_type = "AL2023_x86_64_STANDARD"

  disk_size = 20

  capacity_type = "ON_DEMAND"

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }

  labels = {
    workload = "application"
  }

  tags = merge(
    local.common_tags,
    {
      Name = "calculator-app-ng"
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_worker,
    aws_iam_role_policy_attachment.eks_node_cni,
    aws_iam_role_policy_attachment.eks_node_ecr
  ]
}

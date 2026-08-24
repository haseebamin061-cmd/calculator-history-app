resource "aws_eks_cluster" "main" {
  name     = "calculator-eks"
  role_arn = aws_iam_role.eks_cluster.arn
  version  = "1.36"

  vpc_config {
    subnet_ids = aws_subnet.public[*].id

    security_group_ids = [
      aws_security_group.eks_cluster.id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  tags = merge(
    local.common_tags,
    {
      Name = "calculator-eks"
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster
  ]
}

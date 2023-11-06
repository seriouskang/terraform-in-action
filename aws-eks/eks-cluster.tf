resource "aws_eks_cluster" "test-eks-cluster" {
  name     = local.cluster_name
  role_arn = aws_iam_role.test_cluster.arn
  vpc_config {
    subnet_ids = aws_subnet.test_private[*].id
  }
  depends_on = [
    aws_iam_role_policy_attachment.test_cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.test_cluster_AmazonEKSVPCResourceController,
  ]
}
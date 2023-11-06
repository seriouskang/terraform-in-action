resource "aws_eks_node_group" "test_worker" {
    cluster_name    = local.cluster_name
    node_group_name = "${local.cluster_name}-worker-node-group"
    node_role_arn   = aws_iam_role.test_worker.arn
    subnet_ids      = aws_subnet.test_private[*].id
    
    scaling_config {
        desired_size = var.test_worker_size.desired
        min_size     = var.test_worker_size.min
        max_size     = var.test_worker_size.max
    }

    depends_on = [
        aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly
    ]
}
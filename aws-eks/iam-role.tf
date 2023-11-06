resource "aws_iam_role" "test_cluster" {
  name = "${local.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role" "test_worker" {
    name = "${local.cluster_name}-eks-worker-role"

    assume_role_policy = jsonencode({
        Statement = [{
            Effect = "Allow",
            Action = "sts:AssumeRole",
            Principal = {
                Service = "ec2.amazonaws.com"
            }
        }]
    })
}
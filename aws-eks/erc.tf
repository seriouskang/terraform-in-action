resource "aws_ecr_repository" "test_repository" {
    name = local.repository_name
}
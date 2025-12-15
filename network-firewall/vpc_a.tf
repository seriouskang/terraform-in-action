resource "aws_vpc" "vpc_100" {
  cidr_block           = var.vpc_100_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-100"
  }
}
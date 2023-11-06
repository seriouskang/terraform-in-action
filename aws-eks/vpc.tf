resource "aws_vpc" "this" {
  cidr_block = local.cidr_block
  tags = {
    Name = local.vpc_name
  }
}
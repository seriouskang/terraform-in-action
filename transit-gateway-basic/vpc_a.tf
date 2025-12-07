resource "aws_vpc" "vpc_a" {
  cidr_block           = var.vpc_a_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tgw-lab-vpc-a-web"
  }
}

resource "aws_subnet" "vpc_a_subnet" {
  vpc_id                  = aws_vpc.vpc_a.id
  cidr_block              = cidrsubnet(var.vpc_a_cidr, 8, 1)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "tgw-lab-vpc-a-public-subnet"
  }
}
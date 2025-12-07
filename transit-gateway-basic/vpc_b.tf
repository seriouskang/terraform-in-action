resource "aws_vpc" "vpc_b" {
  cidr_block           = var.vpc_b_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tgw-lab-vpc-b-web"
  }
}

resource "aws_subnet" "vpc_b_subnet" {
  vpc_id                  = aws_vpc.vpc_b.id
  cidr_block              = cidrsubnet(var.vpc_b_cidr, 8, 0)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "tgw-lab-vpc-b-public-subnet"
  }
}

resource "aws_internet_gateway" "vpc_b_igw" {
  vpc_id = aws_vpc.vpc_b.id

  tags = {
    Name = "tgw-lab-vpc-b-igw"
  }  
}

resource "aws_route_table" "vpc_b_public" {
  vpc_id = aws_vpc.vpc_b.id

  tags = {
    Name = "tgw-labl-vpc-b-public-rt"
  }
}

resource "aws_route" "vpc_b_internet" {
  route_table_id         = aws_route_table.vpc_b_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_b_igw.id
}
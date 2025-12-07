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
  cidr_block              = cidrsubnet(var.vpc_a_cidr, 8, 0)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "tgw-lab-vpc-a-public-subnet"
  }
}

resource "aws_internet_gateway" "vpc_a_igw" {
  vpc_id = aws_vpc.vpc_a.id

  tags = {
    Name = "tgw-lab-vpc-a-igw"
  }  
}

resource "aws_route_table" "vpc_a_public" {
  vpc_id = aws_vpc.vpc_a.id

  tags = {
    Name = "tgw-labl-vpc-a-public-rt"
  }
}

resource "aws_route" "vpc_a_internet" {
  route_table_id         = aws_route_table.vpc_a_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_a_igw.id
}
resource "aws_vpc" "vpc_c" {
  cidr_block           = var.vpc_c_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tgw-lab-vpc-c-web"
  }
}

resource "aws_subnet" "vpc_c_subnet" {
  vpc_id                  = aws_vpc.vpc_c.id
  cidr_block              = cidrsubnet(var.vpc_c_cidr, 8, 0)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "tgw-lab-vpc-c-public-subnet"
  }
}

resource "aws_internet_gateway" "vpc_c_igw" {
  vpc_id = aws_vpc.vpc_c.id

  tags = {
    Name = "tgw-lab-vpc-c-igw"
  }  
}

resource "aws_route_table" "vpc_c_public" {
  vpc_id = aws_vpc.vpc_c.id

  tags = {
    Name = "tgw-labl-vpc-c-public-rt"
  }
}

resource "aws_route" "vpc_c_internet" {
  route_table_id         = aws_route_table.vpc_c_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_c_igw.id
}
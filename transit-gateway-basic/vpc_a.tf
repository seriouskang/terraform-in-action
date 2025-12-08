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

resource "aws_security_group" "vpc_a" {
  name_prefix = "tgw-lab-vpc-a-"
  vpc_id      = aws_vpc.vpc_a.id

  ingress {
    description = "SSH from local"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP from local, VPC B and C"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      var.my_ip,
      var.vpc_b_cidr,
      var.vpc_c_cidr
    ]
  }

  ingress {
    description = "ICMP FROM VPC B and C"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [
      var.vpc_b_cidr,
      var.vpc_c_cidr
    ]
  }

  egress {
    description = "ALLOW all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tgw-lab-vpc-a-sg"
  }
}
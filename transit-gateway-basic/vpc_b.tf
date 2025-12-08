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

resource "aws_route_table_association" "vpc_b_subnet" {
  subnet_id      = aws_subnet.vpc_b_subnet.id
  route_table_id = aws_route_table.vpc_b_public.id
}

resource "aws_security_group" "vpc_b" {
  name_prefix = "tgw-lab-vpc-b-"
  vpc_id      = aws_vpc.vpc_b.id

  ingress {
    description = "SSH from local"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP from local, VPC A and C"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      var.my_ip,
      var.vpc_a_cidr,
      var.vpc_c_cidr
    ]
  }

  ingress {
    description = "ICMP FROM VPC A and C"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [
      var.vpc_a_cidr,
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
    Name = "tgw-lab-vpc-b-sg"
  }
}

resource "aws_instance" "vpc_b_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.vpc_b_subnet.id
  vpc_security_group_ids = [aws_security_group.vpc_b.id]
  key_name               = aws_key_pair.test-key-pair.key_name

  user_data = templatefile(
    "${path.module}/scripts/init.sh", 
    {VPC = "VPC B"}
  )

  tags = {
    Name = "tgw-lab-vpc-b-instance"
  }
}

output "vpc_b_instance" {
  value = aws_instance.vpc_b_instance.public_ip
}
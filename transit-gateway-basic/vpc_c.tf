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

resource "aws_route" "vpc_c_to_vpc_a" {
  route_table_id         = aws_route_table.vpc_c_public.id
  destination_cidr_block = var.vpc_a_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.main.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.vpc_c]
}

resource "aws_route_table_association" "vpc_c_subnet" {
  subnet_id      = aws_subnet.vpc_c_subnet.id
  route_table_id = aws_route_table.vpc_c_public.id
}

resource "aws_security_group" "vpc_c" {
  name_prefix = "tgw-lab-vpc-c-"
  vpc_id      = aws_vpc.vpc_c.id

  ingress {
    description = "SSH from local"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP from local, VPC A and B"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      var.my_ip,
      var.vpc_a_cidr,
      var.vpc_b_cidr
    ]
  }

  ingress {
    description = "ICMP FROM VPC A and B"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [
      var.vpc_a_cidr,
      var.vpc_b_cidr
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
    Name = "tgw-lab-vpc-c-sg"
  }
}

resource "aws_instance" "vpc_c_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.vpc_c_subnet.id
  vpc_security_group_ids = [aws_security_group.vpc_c.id]
  key_name               = aws_key_pair.test-key-pair.key_name

  user_data = templatefile(
    "${path.module}/scripts/init.sh", 
    {VPC = "VPC C"}
  )

  tags = {
    Name = "tgw-lab-vpc-c-instance"
  }
}

output "vpc_c_instance_public_ip" {
  value = aws_instance.vpc_c_instance.public_ip
}

output "vpc_c_instance_private_ip" {
  value = aws_instance.vpc_c_instance.private_ip
}
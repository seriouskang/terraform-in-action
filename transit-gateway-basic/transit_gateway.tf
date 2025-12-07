resource "aws_ec2_transit_gateway" "main" {
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support = "enable"
  vpn_ecmp_support = "enable"

  tags = {
    Name = "tgw-lab-main"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_a" {
  subnet_ids         = [aws_subnet.vpc_a_subnet.id]
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = aws_vpc.vpc_a.id

  dns_support = "enable"

  tags = {
    Name = "tgw-lab-attachment-vpc-a"
  }
}
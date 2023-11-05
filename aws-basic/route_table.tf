resource "aws_route_table" "test_route_table" {
    vpc_id = aws_vpc.test_vpc.id

    tags = {
        Name = "test route table"
    }
}

resource "aws_route_table_association" "route_table_association_1" {
    subnet_id      = aws_subnet.first_subnet.id
    route_table_id = aws_route_table.test_route_table.id
}

resource "aws_route_table_association" "route_table_association_2" {
    subnet_id      = aws_subnet.second_subnet.id
    route_table_id = aws_route_table.test_route_table.id 
}

# route to internet
resource "aws_route" "test_route_igw" {
    route_table_id = aws_route_table.test_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
}
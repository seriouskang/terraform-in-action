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
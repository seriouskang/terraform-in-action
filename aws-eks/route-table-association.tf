resource "aws_route_table_association" "test_public" {
    count = length(local.public_subnets)
    
    subnet_id      = aws_subnet.test_public[count.index].id
    route_table_id = aws_route_table.test_public.id
}

resource "aws_route_table_association" "test_private" {
    count = length(local.private_subnets)

    subnet_id      = aws_subnet.test_private[count.index].id
    route_table_id = aws_route_table.test_private.id
}
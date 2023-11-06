resource "aws_route" "test_public_worldwide" {
    route_table_id         = aws_route_table.test_public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.this.id
}

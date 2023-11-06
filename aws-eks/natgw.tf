resource "aws_nat_gateway" "this" {
    allocation_id = aws_eip.test_natgw.id
    subnet_id     = aws_subnet.test_public[0].id
    tags = {
        Name = "${local.vpc_name}-natgw"
    } 
}
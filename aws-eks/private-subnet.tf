resource "aws_subnet" "test_private" {
    count = length(local.private_subnets)

    vpc_id            = aws_vpc.this.id
    cidr_block        = local.private_subnets[count.index]
    availability_zone = local.azs[count.index]
    tags ={
        Name = "${local.vpc_name}-private-${count.index + 1}"       
    }
}
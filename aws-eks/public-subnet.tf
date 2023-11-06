resource "aws_subnet" "test_public" {
    count = length(local.public_subnets)
    
    vpc_id            = aws_vpc.this.id
    cidr_block        = local.public_subnets[count.index]
    availability_zone = local.azs[count.index]
    tags = {
        Name = "${local.vpc_name}-public-${count.index + 1}"
    }
}
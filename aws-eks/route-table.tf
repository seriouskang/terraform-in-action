resource "aws_route_table" "test_public" {
    vpc_id = aws_vpc.this.id
    tags = {
        Name = "${local.vpc_name}-public"
    }
}
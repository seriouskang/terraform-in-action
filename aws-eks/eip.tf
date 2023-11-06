resource "aws_eip" "test_natgw" {
    tags = {
        Name = "${local.vpc_name}-natgw"
    }
}
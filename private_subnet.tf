resource "aws_subnet" "first_private_subnet" {
    vpc_id     = aws_vpc.test_vpc.id
    cidr_block = "10.150.3.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "test private subnet-1"
    }
}

resource "aws_subnet" "second_private_subnet" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.150.4.0/24"

    availability_zone = "ap-northeast-2b"

    tags = {
        Name = "test private subnet-2"
    }
}
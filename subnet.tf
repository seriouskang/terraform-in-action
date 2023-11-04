resource "aws_subnet" "first_subnet" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.150.1.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "test subnet-1"
    }
}

resource "aws_subnet" "second_subnet" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = "10.150.2.0/24"

    availability_zone = "ap-northeast-2b"

    tags = {
        Name = "test subnet-2"
    }
}
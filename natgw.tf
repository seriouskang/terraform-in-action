resource "aws_eip" "first_nat" {
    vpc = true

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "test nat eip-1"
    }
}

resource "aws_eip" "second_nat" {
    vpc = true

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "test nat eip-2"
    }
}

resource "aws_nat_gateway" "first_nat_gateway" {
    allocation_id = aws_eip.first_nat.id

    # connect a public subnet, not a private subnet
    subnet_id = aws_subnet.first_subnet.id

    tags = {
        Name = "test natgw-1"
    }
}

resource "aws_nat_gateway" "second_nat_gateway" {
    allocation_id = aws_eip.second_nat.id

    subnet_id = aws_subnet.second_subnet.id

    tags = {
        Name = "test natgw-2"
    }
}
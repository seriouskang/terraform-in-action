provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.150.0.0/16"
  
  tags = {
    Name = "test vpc"
  }
}
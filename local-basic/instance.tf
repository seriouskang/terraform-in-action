provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "example" {
    ami           = "ami-0c1508b5372d244d7"
    instance_type = var.instance_type
}

resource "aws_instance" "map-example" {
    ami           = "ami-0c1508b5372d244d7"
    # instance_type = var.map_instance_type["example"]
    instance_type = var.map_instance_type.example
}
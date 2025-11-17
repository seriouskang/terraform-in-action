resource "aws_instance" "example" {
    ami           = "ami-0c1508b5372d244d7"
    instance_type = var.instance_type

    subnet_id = module.vpc.public_subnets[0]
}

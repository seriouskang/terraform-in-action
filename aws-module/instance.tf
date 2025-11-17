resource "aws_instance" "example" {
    ami           = "ami-0c1508b5372d244d7"
    instance_type = var.instance_type

    subnet_id              = module.vpc.public_subnets[0]
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
    key_name               = aws_key_pair.temp-key.key_name

    tags = {
        Name = "example"
    }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_key_pair" "temp-key" {
  key_name   = "temp-key"
  public_key = file("${path.module}/temp-key.pub")
}
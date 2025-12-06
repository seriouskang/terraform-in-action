resource "aws_instance" "example" {
  ami           = "ami-04fcc2023d6e37430"
  instance_type = "t2.micro"

  subnet_id = "${aws_subnet.main-public-1.id}"

  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  key_name = aws_key_pair.mykeypair.key_name
}
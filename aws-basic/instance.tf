resource "aws_instance" "example" {
  ami           = "${var.INSTANCE_AMI}"
  instance_type = "${var.INSTANCE_TYPE}"

  subnet_id = "${aws_subnet.main-public-1.id}"

  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  key_name = aws_key_pair.mykeypair.key_name
  user_data = templatefile("${path.module}/scripts/init.sh", {
    DEVICE = "${var.INSTANCE_DEVICE_NAME}"
  })

  iam_instance_profile = aws_iam_instance_profile.s3-test-bucket-role-instanceprofile.name
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "ap-northeast-2a"
  size = 20
  type = "gp2"
  
  tags = {
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "${var.INSTANCE_DEVICE_NAME}"
  volume_id = "${aws_ebs_volume.ebs-volume-1.id}"
  instance_id = "${aws_instance.example.id}"
}

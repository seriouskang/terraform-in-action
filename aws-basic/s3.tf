resource "aws_s3_bucket" "test-bucket" {
  bucket = "test-bucket-251207"

  tags = {
    Name = "test-bucket-251207"
  }
}
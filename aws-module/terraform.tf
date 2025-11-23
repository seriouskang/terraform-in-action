provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  backend "s3" {
    bucket = "terraform-test-251123"
    region = "ap-northeast-2"
    key    = "terraform-state-with-S3"
    dynamodb_table = "terraform-locking"
  }
}
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
        Environment = "tgw-test"
        ManagedBy   = "Terraform"
    }
  }
}
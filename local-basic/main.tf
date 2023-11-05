terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.4.0"
    }
  }

  required_version = ">= 1.0"
}

resource "local_file" "demo" {
  content  = "hello, terraform world!"
  filename = "helloworld.txt"
}
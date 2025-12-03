data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../aws-module/terraform.tfstate"
  }
}

output "vpc_id" {
    value = data.terraform_remote_state.network.outputs.public_ip
}
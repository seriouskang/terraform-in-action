output "public_subnets" {
    value = module.vpc.public_subnets
}

output "public_ip" {
    value = aws_instance.example.public_ip
}

output "account_id" {
    value = data.aws_caller_identity.current
}

output "region" {
    value = data.aws_region.current
}
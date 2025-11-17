output "public_subnets" {
    value = module.vpc.public_subnets
}

output "public_ip" {
    value = aws_instance.example.public_ip
}
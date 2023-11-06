locals {
    vpc_name        = "test-eks"
    cidr_block      = "10.150.0.0/16"
    public_subnets  = ["10.150.0.0/24", "10.150.1.0/24"]
    private_subnets = ["10.150.100.0/24", "10.150.101.0/24"]
    azs             = ["ap-southeast-1a", "ap-southeast-1c"]
    cluster_name    = "test-eks"
}
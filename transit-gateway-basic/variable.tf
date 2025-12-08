variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "ap-northeast-2"
}

variable "vpc_a_cidr" {
    type    = string
    default = "10.100.0.0/16"
}

variable "vpc_b_cidr" {
    type    = string
    default = "10.101.0.0/16"
}

variable "vpc_c_cidr" {
    type    = string
    default = "10.102.0.0/16"
}

variable "my_ip" {
    type = string
}

variable "instance_type" {
    type    = string
    default = "t3.micro"
}

variable "ami_id" {
    type    = string
    default = "ami-04fcc2023d6e37430"
}

variable "public_key" {
    type = string
}
variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "ap-northeast-2"
}

variable "vpc_a_cidr" {
    type = string
    default = "10.100.0.0/16"
}

variable "vpc_b_cidr" {
    type = string
    default = "10.101.0.0/16"
}

variable "vpc_c_cidr" {
    type = string
    default = "10.102.0.0/16"
}
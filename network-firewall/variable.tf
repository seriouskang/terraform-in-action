variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "ap-northeast-2"
}

variable "vpc_100_cidr" {
    type    = string
    default = "10.100.0.0/16"
}

variable "INSTANCE_AMI" {
  default = "ami-04fcc2023d6e37430"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"  
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "temp-key.pub"
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}
variable "region" {
    description = "The AWS region to create resources in"
}

variable "vpc_cidr_block" {
    description = "The CIDR block for the VPC"
}

variable "public_subnet_cidr_block" {
    description = "The CIDR block for the public subnet"
}
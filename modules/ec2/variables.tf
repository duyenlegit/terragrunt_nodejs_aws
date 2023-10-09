variable "region" {
    description = "The AWS region to create resources in"
}

variable "subnet_id" {
    description = "The ID of the subnet to place the EC2 instance in"
}

variable "instance_type" {
    description = "The Amazon EC2 instance type"
}

variable "ami_id" {
    description = "The Amazon Machine Image (AMI) ID for the EC2 instance"
}

variable "vpc_id" {
    description = "The ID of the VPC to create the security group in"
}

variable "key_name" {
  description = "SSH Key Pair for EC2 instance"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
}
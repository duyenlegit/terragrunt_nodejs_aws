module "my_vpc" {
    source = "./modules/vpc"

    region                  = "ap-southeast-1"
    vpc_cidr_block          = "10.0.0.0/16"
    public_subnet_cidr_block = "10.0.1.0/24"
}

module "my_ec2" {
    source       = "./modules/ec2"
    region       = "ap-southeast-1"
    vpc_id        = module.my_vpc.vpc_id 
    subnet_id    = module.my_vpc.public_subnet_id
    instance_type = "t2.micro"
    ami_id        = "ami-0df7a207adb9748c7" 
    key_name = module.aws_instance.this.key_name
    instance_name = module.aws_instance.tags
}

/*output "vpc_id" {
    value = module.my_vpc.vpc_id
}

output "public_subnet_id" {
    value = module.my_vpc.public_subnet_id
}

output "instance_id" {
    value = module.my_ec2.instance_id
}

output "instance_public_ip" {
    value = module.my_ec2.instance_public_ip
}
*/
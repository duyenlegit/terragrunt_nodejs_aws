/*provider "aws" {
  region = "ap-southeast-1"
  profile = "default"
}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  tags = {    Name = "nodejs-vpc"   }
}

locals {
  public_cidr = ["10.0.1.0/24"]
  //availability_zone = ["ap-southeast-1a", "ap-southeast-1b"]
  key_name = "ec2_key_pair"
}

resource "aws_subnet" "public" {
  count = length(local.public_cidr)
  vpc_id            = aws_vpc.this.id
  cidr_block        = local.public_cidr[count.index]
# availability_zone = var.availability_zone[count.index % length(var.availability_zone)]
  map_public_ip_on_launch = true # Enable auto-assign public IP

  tags = {    Name = "public-subnet"  }
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = local.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  owners = ["099720109477"] # canonical ubuntu aws account id  
}

resource "aws_instance" "nodejs" {
  count = 1 
  ami           = "ami-0df7a207adb9748c7"
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_all.id]

  subnet_id          = aws_subnet.public[count.index].id 

  user_data = file("${path.module}/install_nodejs_app.sh")

  tags = {
    Name = "Nodejs-App"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id
  tags = {    name = "nodejs_ig"   }
}

resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {     name = "route table to connect public subnets to ig"  }
}

resource "aws_route_table_association" "public_subnet_association" {
  for_each = { for k,v in aws_subnet.public: k => v }
  subnet_id = each.value.id
  route_table_id = aws_route_table.second_rt.id
}
*/
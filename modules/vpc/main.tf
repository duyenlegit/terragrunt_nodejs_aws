provider "aws" {
    region = var.region
}

resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr_block

    tags = {
        Name = "my-vpc"
    }
}

resource "aws_subnet" "public" {
    cidr_block = var.public_subnet_cidr_block
    vpc_id     = aws_vpc.this.id
    map_public_ip_on_launch = true # Enable auto-assign public IP

    tags = {
        Name = "public-subnet"
    }
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "my-internet-gateway"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "public-route-table"
    }
}

resource "aws_route" "public" {
    route_table_id         = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
    subnet_id      = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}
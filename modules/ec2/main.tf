/*provider "aws" {
    region = var.region
}

resource "aws_security_group" "allow_ssh" {
    name        = "allow_all"
    description = "Allow all traffic"
    vpc_id      = var.vpc_id

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
  key_name   = "ec2_key_pair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "this" {
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = var.subnet_id
    key_name      = aws_key_pair.deployer.key_name

    vpc_security_group_ids = [aws_security_group.allow_ssh.id]

    user_data = file("${path.module}/install_nodejs_app.sh")
    tags = {
        Name = "example-instance"
    }
}
*/
resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  user_data     = file("${path.module}/install_nodejs.sh")

  tags = {
    Name = var.instance_name
  }
}
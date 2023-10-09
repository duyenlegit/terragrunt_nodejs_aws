terraform {
  source = "../../../modules/ec2"
}

inputs = {
  ami_id        = "ami-0df7a207adb9748c7" # Replace with a suitable Amazon Linux 2 AMI ID for your region
  instance_type = "t2.micro"
  key_name      = "ec2_key_pair" # Replace with your SSH key pair name configured in AWS
  subnet_id     = "subnet-0abcdef123456789" # Replace with your VPC subnet ID
  instance_name = "my-dev-instance"
}
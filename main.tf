provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" { # fetch latest ubuntu 24.04 AMI image
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "my_ec2" {
  ami = data.aws_ami.ubuntu.id # AMI image
  instance_type = var.ec2_type # ec2 type -> t3.micro
  tags = {
    Name = var.ec2_name # name tag/column of the ec2 in AWS
  }
  key_name = "ec2_key_pair" # AWS EC2 SSH key pair
}
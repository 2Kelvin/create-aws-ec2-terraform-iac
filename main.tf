provider "aws" {
  region = "us-east-1"
}

# fetch latest ubuntu 24.04 AMI image
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Canonical
}

# Security Group Setup
resource "aws_security_group" "my_cicd_securitygroup" {
  description = "My custom security group"
  name        = "my_cicd_securitygroup"
}

# allowing SSH in security group (firewall)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  description       = "Enable SSH port past the EC2 firewall"
  security_group_id = aws_security_group.my_cicd_securitygroup.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  # allow any IP with my ssh key pair to login to EC2 instance
  cidr_ipv4 = "0.0.0.0/0"
}

# allowing all EC2 instance outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  description       = "Allow all outbound traffic from the EC2 instance"
  security_group_id = aws_security_group.my_cicd_securitygroup.id
  # -1 means allow all outbound protocols and port ranges
  ip_protocol = "-1"
  # allowed to talk to all/any IP address on the internet
  cidr_ipv4 = "0.0.0.0/0"
}

# EC2 instance full setup
resource "aws_instance" "my_terraform_ec2" {
  ami           = data.aws_ami.ubuntu.id # AMI image
  instance_type = var.ec2_type           # ec2 type
  tags = {
    Name = var.ec2_name # name tag/column of the ec2 in AWS
  }
  key_name = var.ec2_ssh_key # AWS EC2 SSH key pair
  # using my custom security group for my EC2 instance
  vpc_security_group_ids = [aws_security_group.my_cicd_securitygroup.id]
}

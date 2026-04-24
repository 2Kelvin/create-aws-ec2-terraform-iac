variable "ec2_name" {
  description = "Name of the AWS EC2 instance"
  type        = string
  default     = "ec2_with_docker"
}

variable "ec2_type" {
  description = "Type of the AWS EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "ec2_ssh_key" {
  description = "AWS EC2 instance SSH key pair"
  type        = string
  default     = "ec2_key_pair"
}

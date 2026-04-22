variable "ec2_name" {
  description = "Name of the AWS EC2 instance"
  type        = string
  default     = "my-terraform-ec2"
}

variable "ec2_type" {
  description = "Type of the AWS EC2 instance"
  type        = string
  default     = "t3.micro"
}

# fetch my EC2's public IP to be used for SSHing into instance later
output "ec2_public_ip" {
  description = "EC2's Public IP"
  value       = aws_instance.ec2_with_docker.public_ip
}

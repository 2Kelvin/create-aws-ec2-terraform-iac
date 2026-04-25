terraform {
  # uncomment this cloud block to connect to HCP Terraform to store & manage aws infrastructure state remotely
  # cloud {
  #   organization = "my_iac_projects"
  #   workspaces {
  #     project = "EC2 With Docker"
  #     name    = "ec2-docker"
  #   }
  # }

  # AWS provider
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }
  }

  # Terraform version
  required_version = ">=1.14.9"
}

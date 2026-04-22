terraform {
  # connecting to HCP Terraform to store and manage my aws resources state
  cloud {
    organization = "my_iac_projects"
    workspaces {
      project = "Full Automated CICD Pipeline"
      name = "automated-cicd"
    }
  }

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

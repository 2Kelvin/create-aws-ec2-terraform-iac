# Automated EC2 Provisioning with Terraform & Docker

This repository contains Terraform configurations to deploy a secure, production-ready AWS EC2 instance. The infrastructure is designed to automatically install and configure Docker on startup, enabling immediate container orchestration upon deployment.

## 🏗️ Architecture Overview

The deployment utilizes a modular Terraform approach:

- **Infrastructure Provider**: AWS (us-east-1).

- **Compute**: EC2 instance using the latest Ubuntu 24.04 LTS AMI (dynamically fetched).

- **Security**: Custom Security Group with restricted Ingress (SSH) and full Egress for updates.

- **Automation**: user_data injection via a shell script for automated Docker Engine installation.

- **State Management**: Remote state storage via HCP Terraform.

## 🛠️ Tech Stack

- **IaC**: Terraform >= 1.14.9
- **Cloud**: AWS (EC2, IAM, VPC)
- **OS**: Ubuntu 24.04 (Noble Numbat)
- **Containerization**: Docker (Engine & Compose)
- **CI/CD**: Terraform / HCP Terraform Cloud

## 🚀 Getting Started

### 1. Prerequisites

- An AWS Account and IAM user with programmatic access.
- Terraform CLI installed locally.
- An existing AWS SSH Key Pair named _ec2_key_pair_.

### 2. Environment Configuration

Set your AWS credentials as environment variables to allow Terraform to authenticate with the AWS API.

To allow `Terraform's AWS provider` to talk to the `AWS API`, create an access token for your `IAM user` in `AWS Console`:

- For local Terraform use, assign the access token details to these 2 environment variables in your terminal:
  ```bash
  export AWS_ACCESS_KEY_ID=<your_access_token_id_here>
  export AWS_SECRET_ACCESS_KEY=<your_access_token_secret_here>
  ```
- For HCP Terraform, assign the access token to your project's workspace `Variables Section`. Assign the 2 access tokens details/values `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as `environment variables` and mark them as `sensitive` for security. Remember to run `terraform login` in your terminal to login to HCP Terraform to setup an access token to use for remote IAC implementation.
  <img width="1581" height="490" alt="access_token_img" src="https://github.com/user-attachments/assets/e0811993-2282-4b2e-aade-b084a78560df" />

### 3. Deployment

- Initialize terraform project

  ```bash
  terraform init
  ```

- Create the EC2 instance in AWS. When prompted type **yes** to allow EC2 provisioning.
  ```bash
  terraform apply
  ```

## 📊 Outputs

Upon successful application, Terraform will output the Public IP. You can SSH into your EC2 instance using:

```bash
ssh -i "path/to/your/key.pem" ubuntu@$your_ec2_public_ip
```

## 💡 My Key Takeaways & Things I've Learnt

1. You need to specifically define a `Security Group` and associated `Security Group Ingress/Egress` block rules in Terraform to open any ports to connect to your instance or allow it to connect to the internet and other resources.

2. Use EC2's `public IPV4 address` for SSHing (just like you would a regular VM) rather than the long EC2's `public IPV4 DNS URL`.
   - The DNS resolution of `IPV4 DNS URL` is slower than the `IPV4 address` when SSHing to instance.
   - The `IPV4 DNS URL` is actually derived from the `IPV4 Address` as seen in its URL
   - Both `IPV4 DNS URL` and `IPV4 Address` change every time the instance is stopped and started
   - For a consistent and unchanging IPV4 Address use `Elastic IP`

3. A `Security Group` is just a fancy name for `Firewall (Allow/Deny Rules)`.

## 🔍 Issues I faced and fixed

1. EC2 not accessible: Connection timed out when trying to connect to the instance using SSH.
   - **Fix**: I resolved this by creating a security group (Firewall) and defining an allow SSH rule which I linked to my security group in terraform. By default Terraform assigns a default Security Group in which all incoming ports are disabled for security purposes. To allow ports usage like SSH (22) you have to explicitly define a Security Group and an SSH rule. Note: Remember to add the `key_pair name` attribute in the instance to allow connections through SSH.

2. I did not know how to have the EC2 built preinstalled with Docker without having to use extra tools like Ansible.
   - **Fix**: I learnt about the `user_data` instance attribute and used it to pass commands/script to run on instance startup. In my case I passed the `install-docker.sh` script which does exactly that; install docker into the EC2 on start up.

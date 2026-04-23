# Create an AWS EC2 Instance Using Terraform (IAC)

Creating an AWS EC2 instance using Terraform

## Remember

To run `terraform login` in y our terminal to login to HCP Terraform (if needed) inorder to setup an access token to use for IAC implementations.

## Key points to note:

To allow `Terraform's AWS provider` to talk to the `AWS API`, create an access token for your `IAM user`:

- For local Terraform use, assign the access token details to these 2 environment variables in your terminal:
  ```bash
  export AWS_ACCESS_KEY_ID=<your_access_token_id_here>
  export AWS_SECRET_ACCESS_KEY=<your_access_token_secret_here>
  ```
- For HCP Terraform, assign the access token to your project's workspace `Variables Section`. Assign the 2 access tokens details/values `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as `environment variables` and mark them as `sensitive` for security.
  <img width="1581" height="490" alt="access_token_img" src="https://github.com/user-attachments/assets/e0811993-2282-4b2e-aade-b084a78560df" />

- You need to specifically define a `Security Group` and associated `Security Group Ingress/Egress` block rules in Terraform to open any ports to connect to your instance or allow it to connect to the internet and other resources.

## New Things I've Learnt

- Use EC2's `public IPV4 address` for SSHing (just like a regular VM) rather than the long EC2's `public IPV4 DNS URL`.
  - The DNS resolution of `IPV4 DNS URL` makes it slower than the `IPV4 address` when SSHing/connecting to instance.
  - The `IPV4 DNS URL` is actually derived from the `IPV4 Address` as seen in its name in the URL
  - Both `IPV4 DNS URL` and `IPV4 Address` change every time the instance is stopped and started
  - For a consistent IPV4 Address use `Elastic IP`
- A `Security Group` is just a fancy name for `Firewall (Allow/Deny Rules)`.

## Issues I faced

- EC2 not accessible: Connection timed out when trying to connect to the container using SSH.
  - **Fix**: I resolved this by creating a security group (Firewall) and defining an allow SSH rule in the security group in terraform. By default Terraform assigns no default Security Group and all incoming ports are disabled. To allow ports usage like SSH (22) you have to explicitly define a Security Group and SSH rule.

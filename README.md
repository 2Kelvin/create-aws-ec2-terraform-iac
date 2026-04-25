# Create an AWS EC2 Instance Using Terraform (IAC)

Creating an AWS EC2 instance using Terraform and installing `Docker` automatically on EC2 startup

## Key Takeaways

1. Remember to run `terraform login` in your terminal to login to HCP Terraform (if needed) inorder to setup an access token to use for remote IAC implementation.

2. To allow `Terraform's AWS provider` to talk to the `AWS API`, create an access token for your `IAM user` in `AWS Console`:

- For local Terraform use, assign the access token details to these 2 environment variables in your terminal:
  ```bash
  export AWS_ACCESS_KEY_ID=<your_access_token_id_here>
  export AWS_SECRET_ACCESS_KEY=<your_access_token_secret_here>
  ```
- For HCP Terraform, assign the access token to your project's workspace `Variables Section`. Assign the 2 access tokens details/values `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as `environment variables` and mark them as `sensitive` for security.
  <img width="1581" height="490" alt="access_token_img" src="https://github.com/user-attachments/assets/e0811993-2282-4b2e-aade-b084a78560df" />

3. You need to specifically define a `Security Group` and associated `Security Group Ingress/Egress` block rules in Terraform to open any ports to connect to your instance or allow it to connect to the internet and other resources.

## New Things I've Learnt

1. Use EC2's `public IPV4 address` for SSHing (just like a regular VM) rather than the long EC2's `public IPV4 DNS URL`.

- The DNS resolution of `IPV4 DNS URL` is slower than the `IPV4 address` when SSHing to instance.
- The `IPV4 DNS URL` is actually derived from the `IPV4 Address` as seen in its URL
- Both `IPV4 DNS URL` and `IPV4 Address` change every time the instance is stopped and started
- For a consistent and unchanging IPV4 Address use `Elastic IP`

2. A `Security Group` is just a fancy name for `Firewall (Allow/Deny Rules)`.

## Issues I faced

- EC2 not accessible: Connection timed out when trying to connect to the container using SSH.
  - **Fix**: I resolved this by creating a security group (Firewall) and defining an allow SSH rule which I linked to my security group in terraform. I also added the `key_pair name` attribute in the instance to connect through in SSH. By default Terraform assigns a default Security Group in which all incoming ports are disabled for security purposes. To allow ports usage like SSH (22) you have to explicitly define a Security Group and SSH rule.

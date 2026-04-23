# Create an AWS EC2 Instance Using Terraform (IAC)

Creating an AWS EC2 instance using Terraform

### Remember

To run `terraform login` to login to HCP Terraform (if needed) inorder to setup the access token to use for any IAC implementations.

### Key points to note:

To allow `Terraform's AWS provider` to talk to the `AWS API`, create an access token for your IAM user:

- For local Terraform use, assign the access token details to these 2 environment variables in your terminal:
  ```bash
  export AWS_ACCESS_KEY_ID=<your_access_token_id_here>
  export AWS_SECRET_ACCESS_KEY=<your_access_token_secret_here>
  ```
- For HCP Terraform, assign the access token to your project's workspace `Variables Section`. Assign the 2 access tokens details/values `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as `environment variables` and mark them as `sensitive` for security.
  <img width="1581" height="490" alt="access_token_img" src="https://github.com/user-attachments/assets/e0811993-2282-4b2e-aade-b084a78560df" />

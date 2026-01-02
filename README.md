# Automated Infrastructure Provisioning with GitHub Actions & Terraform

A concise example demonstrating how to provision and manage AWS infrastructure using Terraform and GitHub Actions. The repository includes workflows to deploy infrastructure and to destroy it safely, while storing Terraform state in an S3 backend.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Workflows](#workflows)
- [Terraform Backend](#terraform-backend)
- [Testing & Validation](#testing--validation)
- [Best Practices](#best-practices)
- [License](#license)
- [Author](#author)

## Overview
This project provides a minimal, secure CI/CD pattern for infrastructure as code (IaC):
- Use Terraform to declare infrastructure resources (EC2, S3 backend).
- Use GitHub Actions to run `terraform init`, `plan`, `apply`, and `destroy` in CI.
- Keep remote state in an S3 bucket and follow best practices for locking and credentials.

## Features
- Infrastructure as Code (Terraform)
- Automated deploy workflow (on push)
- Manual destroy workflow (manual trigger)
- Remote state storage in S3
- Credentials injected via GitHub Actions Secrets

## Prerequisites
- An AWS account
- An IAM user with appropriate permissions (S3, EC2; prefer least privilege)
- A pre-created S3 bucket for the Terraform backend (same region as your resources)
- GitHub repository with Actions enabled

## Quick Start
1. Clone the repository:

```bash
git clone https://github.com/your-username/gh-actions-tf-lab.git
cd gh-actions-tf-lab
```

2. Configure the Terraform backend in `main.tf`:

```hcl
terraform {
  backend "s3" {
    bucket = "your-unique-bucket-name"
    key    = "github-actions/terraform.tfstate"
    region = "us-east-1"
  }
}
```

3. Configure GitHub Secrets: Repository -> Settings -> Secrets and variables -> Actions
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

4. Commit and push to `main` to trigger the deploy workflow, or run the destroy workflow manually from the Actions tab.

## Workflows
- `.github/workflows/deploy.yml` — Runs on push to `main`, performs `terraform init` and `apply` to create resources.
- `.github/workflows/destroy.yml` — Manual workflow (`workflow_dispatch`) which runs `terraform destroy` to tear down resources.

## Terraform Backend
Remote state is stored in S3. For production use, configure DynamoDB for state locking to prevent concurrent modifications.

## Testing & Validation
- Locally: run `terraform init` → `terraform plan` → `terraform apply` (use a separate workspace or test account).
- CI: push to `main` and inspect the Actions run for `deploy.yml`.
- Cleanup: use the `Destroy Infrastructure` workflow or run `terraform destroy` locally.

## Best Practices
- Use least-privilege IAM roles for automation.
- Prefer short-lived credentials or GitHub OIDC for AWS authentication.
- Enable state locking with DynamoDB for team environments.
- Add `terraform fmt`, `terraform validate`, and `plan` steps to CI for safety.

## License
This project is provided under the MIT License. (Update as necessary)

## Author
Tayyab — Cloud & DevOps Engineer

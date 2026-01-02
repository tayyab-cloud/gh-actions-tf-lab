terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
  bucket = "my-tf-state-tayyab-2026"
  key    = "github-actions/terraform.tfstate"
  region = "us-east-1"
}

}



provider "aws" {
  region = "us-east-1"
  # Credentials hum GitHub Actions se inject krain gy environment variables k zariye
}

resource "aws_instance" "my_server" {
  ami           = "ami-068c0051b15cdb816" # Ubuntu AMI (us-east-1)
  instance_type = "t2.micro"

  tags = {
    Name = "Deployed-via-Github-Actions"
  }
}
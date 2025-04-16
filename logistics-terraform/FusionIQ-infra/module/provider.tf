terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
  #  backend "s3" {
  #   bucket         = "terraform-3tier-arech"
  #   key            = "state/vpc-test"
  #   region         = "us-east-2"
  #   encrypt        = true
  #   dynamodb_table = "dev-tfvar"
  # }
}


provider "aws" {
  # Configuration optionsS
  region = var.region
}
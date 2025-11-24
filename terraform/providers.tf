# Required providers and versions for EKS
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.12.0"
      # AWS provider for EKS, VPC, IAM resources
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.7"
    }

  }
}

provider "aws" {
  region = local.region
}

# AWS Provider configuration
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}



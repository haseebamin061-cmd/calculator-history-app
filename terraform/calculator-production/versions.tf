terraform {
  required_version = ">= 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "haseeb-calculator-terraform-state-375760496125"
    key    = "calculator-production/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

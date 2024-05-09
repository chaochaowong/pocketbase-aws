terraform {
  required_version = "~> 1.7"

  # backend "local" {
  #   path = "terraform.tfstate"
  # }

   backend "s3" {
     bucket = "chao2row2-tf-state"
     key    = "pocketbase-aws/terraform.tfstate"
     region = "us-west-2"
   }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39"
    }
  }
}

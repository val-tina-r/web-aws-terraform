terraform {
  backend "s3" {
    bucket  = "valentina-terraform-123"
    key     = "terraform/state/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
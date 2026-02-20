terraform {
  backend "s3" {
    bucket         = "strapi-terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

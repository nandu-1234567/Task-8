terraform {
  backend "s3" {
    bucket         = "strapi-terraform-state-bucket"
    key            = "strapi/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ecr_image_uri" {
  type    = string
  default = "811738710312.dkr.ecr.us-east-1.amazonaws.com/strapi:latest"
}

variable "app_port" {
  type    = number
  default = 1337
}

data "aws_availability_zones" "available" {}


# Reference existing default VPC
data "aws_vpc" "existing" {
  default = true
}

# Reference all subnets in the VPC
data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.existing.id
}


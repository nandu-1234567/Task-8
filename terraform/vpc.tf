# Get all availability zones in the current region
data "aws_availability_zones" "available" {}

# Reference the default VPC in the region
data "aws_vpc" "default" {
  default = true
}

# Get all subnets in the default VPC
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}



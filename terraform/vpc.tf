# Get all availability zones in the current region
data "aws_availability_zones" "available" {}

data "aws_vpc" "existing" {
  id = "vpc-0778ad9a2069279fc"  # Pick one of your existing VPCs
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
}

data "aws_availability_zones" "available" {}


# Reference existing default VPC
data.aws_vpc.existing.id {
  default = true
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
}

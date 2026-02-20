data "aws_availability_zones" "available" {}

data "aws_vpc" "default" {
  default = true
}
data "aws_subnets" "public" {
    value = data.aws_vpc.default.id
  }


data "aws_availability_zones" "available" {}

data "aws_vpc" "default" {
  default = true
}
data "aws_subnet_ids" "public" {
    value = data.aws_vpc.default.id
  }


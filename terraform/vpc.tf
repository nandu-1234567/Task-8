data "aws_availability_zones" "available" {}

data "aws_vpc" "default" {
  default = true
}
data "aws_subnet" "public" {
    value = data.aws_vpc.default.id
  }


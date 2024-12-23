resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.tags
}

resource "aws_subnet" "public" {
  count                 = 2
  vpc_id                = aws_vpc.main.id
  cidr_block            = "10.0.${count.index + 1}.0/24"
  availability_zone     = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags                  = merge(var.tags, { "Name" = "public-${count.index}" })
}

resource "aws_subnet" "private" {
  count                 = 2
  vpc_id                = aws_vpc.main.id
  cidr_block            = "10.0.${count.index + 101}.0/24"
  availability_zone     = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  tags                  = merge(var.tags, { "Name" = "private-${count.index}" })
}

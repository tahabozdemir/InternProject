resource "aws_vpc" "ubuntu_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "Ubuntu VPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ubuntu_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "route_table" {
  count = 2
  
  vpc_id = aws_vpc.ubuntu_vpc.id

  tags = {
    Name = "Route Table ${count.index}"
  }
}

resource "aws_route" "route_public" {
  route_table_id         = local.route_table_ids[0]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_subnet" "subnets" {
  for_each          = toset(var.required_subnets)
  vpc_id            = aws_vpc.ubuntu_vpc.id
  cidr_block        = lookup(var.subnet_config[each.key], "cidr")
  availability_zone = lookup(var.subnet_config[each.key], "availability_zone")

  tags = {
    Name = each.key
  }
}

resource "aws_route_table_association" "public" {
  for_each       = {for name, subnet in aws_subnet.subnets: name => subnet if length(regexall("public-", name)) > 0}   
  subnet_id      = each.value.id
  route_table_id = local.route_table_ids[0]
}

resource "aws_route_table_association" "private" {
  for_each       = {for name, subnet in aws_subnet.subnets: name => subnet if length(regexall("private-", name)) > 0}   
  subnet_id      = each.value.id
  route_table_id = local.route_table_ids[1]
}

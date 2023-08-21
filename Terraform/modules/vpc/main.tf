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

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.ubuntu_vpc.id

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route" "route_public" {
  route_table_id         = aws_route_table.rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_subnet" "subnet_public" {
  vpc_id            = aws_vpc.ubuntu_vpc.id
  cidr_block        = var.subnet_public_cidr
  availability_zone = var.subnet_availability_zones[0]

  tags = {
    Name = "Subnet eu-west-1a"
  }
}

resource "aws_route_table_association" "subnet_association_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rt_public.id
}



output "subnets" {
  value = aws_subnet.subnets
}

output "vpc_id" {
  value = aws_vpc.ubuntu_vpc.id
}

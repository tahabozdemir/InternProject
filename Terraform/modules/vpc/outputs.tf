output "vpc_subnet_public_id" {
  value = aws_subnet.subnet_public.id
}

output "vpc_id" {
  value = aws_vpc.ubuntu_vpc.id
}

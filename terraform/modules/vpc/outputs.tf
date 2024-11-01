output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

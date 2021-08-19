output "vpc_id" {
  value = aws_vpc.sa.id
}

output "cidr_block" {
    value = aws_vpc.sa.cidr_block
}

output "route_table" {
    value = aws_vpc.sa
}
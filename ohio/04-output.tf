output "vpc_id" {
  value = aws_vpc.ohio.id
}

output "cidr_block" {
    value = aws_vpc.ohio.cidr_block
}

output "route_table" {
    value = aws_vpc.ohio
}
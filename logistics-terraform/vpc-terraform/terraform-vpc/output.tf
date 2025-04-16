output "az" {
  value = data.aws_availability_zones.available
}
output "public_subnet_ids" {
  value = aws_subnet.logistics_public_subnet[*].id
}
output "vpc_id" {
  value = aws_vpc.logstic_vpc.id  # Ensure this is correctly named
#  value = aws_vpc.logstic_vpc.id
}

output "subnet_private" {
  value = aws_subnet.logistics_private_subnet[*].id
}
output "subnet_private_database" {
  value = aws_subnet.logistics_database_subnet[*].id
}


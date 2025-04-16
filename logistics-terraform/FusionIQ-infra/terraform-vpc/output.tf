output "az" {
  value = data.aws_availability_zones.available
}
output "public_subnet_ids" {
  value = aws_subnet.fusioniq_public_subnet[*].id
}
output "vpc_id" {
  value = aws_vpc.fusioniq_vpc.id  # Ensure this is correctly named
#  value = aws_vpc.fusioniq_vpc.id
}

output "subnet_private" {
  value = aws_subnet.fusioniq_private_subnet[*].id
}
output "subnet_private_database" {
  value = aws_subnet.fusioniq_database_subnet[*].id
}


output "vpc_id" {
  value = module.logstic_vpc.vpc_id # Ensure this matches the actual resource name
}

output "subnet_private" {
  value = module.logstic_vpc.subnet_private
}
output "subnet_private_database" {
  value = module.logstic_vpc.subnet_private_database
}

output "subnet_public" {
  value = module.logstic_vpc.public_subnet_ids
}

output "sg_id" {
  # value = module.logistic.aws_security_group[*].id
  value = module.security_group.sg_id
}

output "public_ip" {
  value = module.bastion-server.public_ip
}


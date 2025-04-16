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

output "cluster_name" {
  value       = module.eks.cluster_name
  description = "The name of the created EKS cluster."
}
output "cluster_version" {
  value       = module.eks.cluster_version
  description = "The version of Kubernetes running on the EKS cluster."
}
output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint for the EKS Kubernetes API server."
}
output "access_entries" {
  value = module.eks.access_entries
}
output "oidc_provider" {
  value = module.eks.oidc_provider
}
output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn

}
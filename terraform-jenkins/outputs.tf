output "public_ip" {
  value       = aws_instance.Logistics-jenkins.public_ip
}

output "private_ip" {
  value       = aws_instance.Logistics-jenkins.private_ip
}

output "instance_id" {
    value = aws_instance.Logistics-jenkins.id
}

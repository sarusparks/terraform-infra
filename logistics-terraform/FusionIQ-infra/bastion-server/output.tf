output "public_ip" {
  value = aws_instance.bastion.public_ip
}
output "nginx_ip" {
  value = aws_instance.nginx.public_ip
}
resource "aws_instance" "Logistics-jenkins" {
  ami           = var.ami
  instance_type = var.instance_type

  user_data = file("${path.module}/jenkins.sh")

  tags = {
    Name = var.instance_name
  }
}
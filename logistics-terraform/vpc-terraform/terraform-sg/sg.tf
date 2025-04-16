resource "aws_security_group" "allow_all_sg" {
  # ... other configuration ...
  count = length(var.sg_name)
  vpc_id = var.vpc_id
  egress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }


  tags = {
    Name = "${var.sg_name[count.index]}"
  }


}
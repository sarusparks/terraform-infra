output "sg_id" {
    value = aws_security_group.allow_all_sg[*].id
}


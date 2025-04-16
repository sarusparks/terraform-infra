resource "aws_db_instance" "fusionis-mysql" {
  identifier              = var.db_identifier
  engine                  = var.db_engine
  engine_version          = var.db_engine_version     
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  storage_type            = var.db_storage_type
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.fusioniq.name  
  parameter_group_name    = aws_db_parameter_group.fusioniq.name
  multi_az               = var.db_multi_az
  publicly_accessible    = var.db_publicly_accessible
  vpc_security_group_ids = var.db_security_group_ids
  skip_final_snapshot    = var.db_skip_final_snapshot
  deletion_protection     = var.db_deletion_protection
  
 
  tags = {
    Name = var.db_identifier
  }
}
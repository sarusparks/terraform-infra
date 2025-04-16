resource "aws_db_parameter_group" "logistics" {
  name        = var.db_parameter_group_name
  family      = var.db_engine_family
  description = "Custom parameter group for PostgreSQL"

  parameter {
    name         = "max_connections"
    value        = var.db_max_connections
    apply_method = "pending-reboot"
  }

  tags = {
    Name = "logisticspostgres-parameter-group"
  }
}
resource "aws_db_subnet_group" "logistics" {
  name        = "logistics-subnet-group"
  description = "Subnet group for RDS"
  subnet_ids  = var.db_subnet_ids # Ensure these subnets exist in your VPC

  tags = {
    Name = "logistics-subnet-group"
  }
}
 
# module "rds" {
#   source                  = "../postgresql-db"
#   vpc_id                  = module.logstic_vpc.vpc_id
#   db_identifier           = var.db_identifier
#   db_engine               = var.db_engine
#   db_engine_version       = var.db_engine_version
#   db_instance_class       = var.db_instance_class
#   db_allocated_storage    = var.db_allocated_storage
#   db_storage_type         = var.db_storage_type
#   db_name                 = var.db_name
#   db_username             = var.db_username
#   db_password             = var.db_password
#   db_subnet_group_name    = var.db_subnet_group_name
#   db_subnet_ids           = module.logstic_vpc.subnet_private_database[*].id
#   db_parameter_group_name = var.db_parameter_group_name
#   db_multi_az             = var.db_multi_az
#   db_publicly_accessible  = var.db_publicly_accessible
#   db_security_group_ids   = module.logistic.aws_security_group[*].id
#   db_skip_final_snapshot  = var.db_skip_final_snapshot
#   db_deletion_protection  = var.db_deletion_protection
#   db_max_connections      = var.db_max_connections
#   db_engine_family        = var.db_engine_family

#    depends_on = [ module.logstic_vpc ]



# }

module "rds" {
  source                  = "../postgresql-db"
  vpc_id                  = module.logstic_vpc.vpc_id
  db_identifier           = var.db_identifier
  db_engine               = var.db_engine
  db_engine_version       = var.db_engine_version
  db_instance_class       = var.db_instance_class
  db_allocated_storage    = var.db_allocated_storage
  db_storage_type         = var.db_storage_type
  db_name                 = var.db_name
  db_username             = var.db_username
  db_password             = var.db_password
  db_subnet_group_name    = var.db_subnet_group_name
  db_subnet_ids           = module.logstic_vpc.subnet_private_database
  db_parameter_group_name = var.db_parameter_group_name
  db_multi_az             = var.db_multi_az
  db_publicly_accessible  = var.db_publicly_accessible
  # db_security_group_ids   = module.logistic.aws_security_group[*].id
  #  db_security_group_ids   = module.logstic_vpc.aws_security_group[*].id
  db_security_group_ids  = module.security_group.sg_id
  db_skip_final_snapshot = var.db_skip_final_snapshot
  db_deletion_protection = var.db_deletion_protection
  db_max_connections     = var.db_max_connections
  db_engine_family       = var.db_engine_family
}

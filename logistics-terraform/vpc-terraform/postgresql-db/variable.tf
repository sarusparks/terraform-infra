variable "db_identifier" {
#   description = "The DB instance identifier"
#   type        = string
#   default     = "logistics-postgres"
}

variable "db_engine" {
#   description = "The database engine to use"
#   type        = string
#   default     = "postgres"
}

variable "db_engine_version" {
#   description = "The engine version to use"
#   type        = string
#   default     = "14"
}

variable "db_instance_class" {
#   description = "The instance class to use"
#   type        = string
#   default     = "db.t3.medium"
}

variable "db_allocated_storage" {
#   description = "The allocated storage size in GB"
#   type        = number
#   default     = 20
}

variable "db_storage_type" {
#   description = "The storage type to use"
#   type        = string
#   default     = "gp2"
}

variable "db_name" {
#   description = "The name of the database to create"
#   type        = string
#   default     = "mydb"
}

variable "db_username" {
#   description = "The master username for the database"
#   type        = string
#   default     = "dbadmin"
}

variable "db_password" {
#   description = "The master password for the database"
#   type        = string
#   sensitive   = true
#   default     = "Admin@12345"
}


variable "db_subnet_group_name" {
#   description = "The DB subnet group name"
#   type        = string
#   default     = "logistics-subnet-group"
}

variable "db_subnet_ids" {
#   description = "List of subnet IDs for the DB subnet group"
#   type        = list(string)
#   default     = ["subnet-0bfb7c523301f4d8b", "subnet-07b6936d2e1d6a8ff"]
}

variable "db_parameter_group_name" {
#   description = "The DB parameter group name"
#   type        = string
#   default     = "logisticspostgres-parameter-group"
}

variable "db_multi_az" {
#   description = "Whether the DB instance is multi-AZ"
#   type        = bool
#   default     = true
}

variable "db_publicly_accessible" {
#   description = "Whether the DB instance is publicly accessible"
#   type        = bool
#   default     = false
}

variable "db_security_group_ids" {
#   description = "List of VPC security group IDs to associate"
#   type        = list(string)
#   default     = ["sg-0d6afedae6d58a9a8"]
}

variable "db_skip_final_snapshot" {
#   description = "Whether to skip the final snapshot when deleting the DB instance"
#   type        = bool
#   default     = false
}

variable "db_deletion_protection" {
#   description = "Whether to enable deletion protection"
#   type        = bool
#   default     = false
}
variable "db_max_connections" {
#   description = "The max connections for the database"
#   type        = number
#   default     = 200
}
variable "db_engine_family" {
#   description = "The family of the DB engine"
#   type        = string
#   default     = "postgres14"
}
 variable "vpc_id" {
  
}
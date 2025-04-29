variable "cidr_block" {
  type        = string
  default     = "10.10.0.0/16"
  description = "CIDR block for the VPC."
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = true
  description = "Enable DNS hostnames for the VPC."
}

variable "tags_common" {
  type = map(string)
  default = {
    terraform = "true"
  }
  description = "Common tags to apply to all resources."
}

variable "project" {
  type        = string
  default     = "logistics"
  description = "Project name for resource identification."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment for the deployment (e.g., dev, staging, prod)."
}

variable "region" {
  type        = string
  default     = "us-east-2"
  description = "AWS region for resource deployment."
}

variable "subnet_public" {
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.2.0/24"]
  description = "List of CIDR blocks for public subnets."

  validation {
    condition     = length(var.subnet_public) == 2
    error_message = "Please enter exactly 2 public subnet CIDR blocks."
  }
}

variable "subnet_public_tag" {
  type = map(string)
  default = {
    internet_access = "true"
  }
  description = "Tags for public subnets."
}

variable "subnet_private" {
  type        = list(string)
  default     = ["10.10.11.0/24", "10.10.12.0/24"]
  description = "List of CIDR blocks for private subnets."

  validation {
    condition     = length(var.subnet_private) == 2
    error_message = "Please enter exactly 2 private subnet CIDR blocks."
  }
}

variable "subnet_private_tag" {
  type = map(string)
  default = {
    internet_access = "false"
  }
  description = "Tags for private subnets."
}

variable "subnet_private_database" {
  type        = list(string)
  default     = ["10.10.21.0/24", "10.10.22.0/24"]
  description = "List of CIDR blocks for private database subnets."

  validation {
    condition     = length(var.subnet_private_database) == 2
    error_message = "Please enter exactly 2 private database subnet CIDR blocks."
  }
}

variable "subnet_private_database_tag" {
  type = map(string)
  default = {
    internet_access = "false"
  }
  description = "Tags for private database subnets."
}

variable "sg_name" {
  type    = list(string)
  default = ["all-allow"]
}


variable "from_port" {
  # type    = number
  # default = [5432, 8080, 80, 22]
  default = 0
}

variable "to_port" {
  # type    = number
  # default = [5432, 8080, 80, 22]
  default = 0
}

variable "db_identifier" {
  description = "The DB instance identifier"
  type        = string
  default     = "logistics-postgres"
}

variable "db_engine" {
  description = "The database engine to use"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "14"
}

variable "db_instance_class" {
  description = "The instance class to use"
  type        = string
  default     = "db.t3.medium"
}

variable "db_allocated_storage" {
  description = "The allocated storage size in GB"
  type        = number
  default     = 20
}

variable "db_storage_type" {
  description = "The storage type to use"
  type        = string
  default     = "gp2"
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
  default     = "mydb"
}

variable "db_username" {
  description = "The master username for the database"
  type        = string
  default     = "dbadmin"
}

variable "db_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
  default     = "SecurePass123!"
}


variable "db_subnet_group_name" {
  description = "The DB subnet group name"
  type        = string
  default     = "logistics-subnet-group"
}

# variable "db_subnet_ids" {
#   description = "List of subnet IDs for the DB subnet group"
#   type        = list(string)
#   # default     = ["subnet-0bfb7c523301f4d8b", "subnet-07b6936d2e1d6a8ff"]
#   default = [  ]
# }

variable "db_parameter_group_name" {
  description = "The DB parameter group name"
  type        = string
  default     = "logisticspostgres-parameter-group"
}

variable "db_multi_az" {
  description = "Whether the DB instance is multi-AZ"
  type        = bool
  default     = true
}

variable "db_publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
  default     = false
}

# variable "db_security_group_ids" {
#   description = "List of VPC security group IDs to associate"
#   type        = list(string)
#    default     = module.module.logistic.aws_security_group[0].id
# }

variable "db_skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the DB instance"
  type        = bool
  default     = true
}

variable "db_deletion_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
  default     = false
}
variable "db_max_connections" {
  description = "The max connections for the database"
  type        = number
  default     = 200
}
variable "db_engine_family" {
  description = "The family of the DB engine"
  type        = string
  default     = "postgres14"
}

variable "ami" {
  default = "ami-0fc82f4dabc05670b"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "cluster_name" {
  default = "logistics-cluster"
}
variable "cluster_version" {
  default = "1.31"
}
variable "node_groups" {
 
  description = "EKS node group configuration"
  type = map(object({
    instance_types = list(string)
    node_group_name = string
    capacity_type  = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
  }))
  default = {
    general = {
      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
      node_group_name = "logistics-node"
      scaling_config = {
        desired_size = 2
        max_size     = 4
        min_size     = 2
      }
    }
  }
}

variable "cidr_block" {
#   type        = string
#   default     = "10.10.0.0/16"
#   description = "CIDR block for the VPC."
}

variable "enable_dns_hostnames" {
#   type        = bool
#   default     = true
#   description = "Enable DNS hostnames for the VPC."
}

variable "tags_common" {
#   type = map(string)
#   default = {
#     terraform = "true"
#   }
#   description = "Common tags to apply to all resources."
}

variable "project" {
#   type        = string
#   default     = "logistics"
#   description = "Project name for resource identification."
}

variable "environment" {
#   type        = string
#   default     = "dev"
#   description = "Environment for the deployment (e.g., dev, staging, prod)."
}

variable "region" {
#   type        = string
#   default     = "us-east-2"
#   description = "AWS region for resource deployment."
}

variable "subnet_public" {
#   type        = list(string)
#   default     = ["10.10.1.0/24", "10.10.2.0/24"]
#   description = "List of CIDR blocks for public subnets."

#   validation {
#     condition     = length(var.subnet_public) == 2
#     error_message = "Please enter exactly 2 public subnet CIDR blocks."
#   }
}

variable "subnet_public_tag" {
#   type = map(string)
#   default = {
#     internet_access = "true"
#   }
#   description = "Tags for public subnets."
}

variable "subnet_private" {
#   type        = list(string)
#   default     = ["10.10.11.0/24", "10.10.12.0/24"]
#   description = "List of CIDR blocks for private subnets."

#   validation {
#     condition     = length(var.subnet_private) == 2
#     error_message = "Please enter exactly 2 private subnet CIDR blocks."
#   }
}

variable "subnet_private_tag" {
#   type = map(string)
#   default = {
#     internet_access = "false"
#   }
#   description = "Tags for private subnets."
}

variable "subnet_private_database" {
#   type        = list(string)
#   default     = ["10.10.21.0/24", "10.10.22.0/24"]
#   description = "List of CIDR blocks for private database subnets."

#   validation {
#     condition     = length(var.subnet_private_database) == 2
#     error_message = "Please enter exactly 2 private database subnet CIDR blocks."
#   }
}

variable "subnet_private_database_tag" {
#   type = map(string)
#   default = {
#     internet_access = "false"
#   }
#   description = "Tags for private database subnets."
}




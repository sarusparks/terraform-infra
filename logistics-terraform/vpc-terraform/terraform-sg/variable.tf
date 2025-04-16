variable "region" {
#   type        = string
#   default     = "us-east-2"
#   description = "AWS region for resource deployment."
}

variable "sg_name" {
#   type    = list(string)
#   default = ["sg-postgre", "sg-backend", "sg-web"]
}


variable "from_port" {
#   type    = list(number)
#   default = [5432, 8080, 80]
}

variable "to_port" {
#   type    = list(number)
#   default = [5432, 8080, 80, 22]
}

variable "vpc_id" {
  
}
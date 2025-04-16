variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-08b5b3a93ed654d19"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "instance_name" {
  description = "Tag name for the EC2 instance"
  type        = string
  default     = "Logistics-jenkins"
}

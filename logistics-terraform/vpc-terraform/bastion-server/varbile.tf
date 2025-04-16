variable "ami" {
 
}

variable "instance_type" {
 
}

# variable "vpc_id" {}  # Ensure this is provided in Terraform apply

variable "public_subnet_ids" {} # Should be a list of subnets

variable "sg_id" {}

//  aws eks update-kubeconfig --name <cluster-name> --region <region>
resource "aws_instance" "bastion" {
  ami             = var.ami                        # Define this in your variables
  instance_type   = var.instance_type              # Define this in your variables
  subnet_id       = element(var.public_subnet_ids, 0)  # Selects the first public subnet
  security_groups = [element(var.sg_id, 0)]           # Selects the first security group
  key_name        = "sidhu@123"                     # Update with a valid key pair name
user_data = base64encode(file("C:/Users/KanaparthiSiddhartha/Documents/logs-surnoi/FusionIQ/FusionIQ-Terraform/FusionIQ-infra/bastion-server/bastion.sh"))
 # user_data                   = base64encode(file("AIML.sh"))
  tags = {
    Name = "bastion-server"                        # Helpful for instance identification
  }
}

resource "aws_instance" "nginx" {
  ami             = var.ami                        # Define this in your variables
  instance_type   = var.instance_type              # Define this in your variables
  subnet_id       = element(var.public_subnet_ids, 1)  # Selects the first public subnet
  security_groups = [element(var.sg_id, 0)]           # Selects the first security group
  key_name        = "sidhu@123"                     # Update with a valid key pair name
 user_data = base64encode(file("C:/Users/KanaparthiSiddhartha/Documents/logs-surnoi/FusionIQ/FusionIQ-Terraform/FusionIQ-infra/bastion-server/nginx.sh"))
 # user_data                   = base64encode(file("AIML.sh"))
  tags = {
    Name = "nginx"                        # Helpful for instance identification
  }
}


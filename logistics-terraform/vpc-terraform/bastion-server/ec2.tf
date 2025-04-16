
# resource "aws_instance" "bastion" {
#   ami             = var.ami
#   instance_type   = var.instance_type
#   subnet_id       = element(var.public_subnet_ids, 0)  # Selects the first subnet
#   security_groups = [element(var.sg_id, 0)]  # Selects the first security group
#    key_name = "sidhu@123"
#   tags = {
#     Name = "bastion-server"
#   }
# }


//  aws eks update-kubeconfig --name <cluster-name> --region <region>
resource "aws_instance" "bastion" {
  ami             = var.ami                        # Define this in your variables
  instance_type   = var.instance_type              # Define this in your variables
  subnet_id       = element(var.public_subnet_ids, 0)  # Selects the first public subnet
  security_groups = [element(var.sg_id, 0)]           # Selects the first security group
  key_name        = "sidhu@123"                     # Update with a valid key pair name
// user_data = base64encode(file("C:/Users/KanaparthiSiddhartha/Documents/DevOps/terraform-sample-project-01/vpc-terraform/bastion-server/bastion.sh"))
 # user_data                   = base64encode(file("AIML.sh"))
  user_data = base64encode(file("${path.module}/bastion.sh"))  

tags = {
    Name = "bastion-server"                        # Helpful for instance identification
  }
}

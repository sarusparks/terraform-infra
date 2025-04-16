# module "bastion-server" {
#   source        = "../bastion-server"
#   instance_type = var.instance_type
#   ami           = var.ami
#   subnet_id     = module.logstic_vpc.public_subnet_ids
#   sg_id         = module.security_group.sg_id
# }

module "bastion-server" {
  source            = "../bastion-server"
  instance_type     = var.instance_type
  ami               = var.ami
  public_subnet_ids = module.logstic_vpc.public_subnet_ids
  sg_id             = module.security_group.sg_id
  #   vpc_id = module.logstic_vpc.vpc_id
}

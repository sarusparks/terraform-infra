module "bastion-server" {
  source            = "../bastion-server"
  instance_type     = var.instance_type
  ami               = var.ami
  public_subnet_ids = module.fusioniq_vpc.public_subnet_ids
  sg_id             = module.security_group.sg_id
}

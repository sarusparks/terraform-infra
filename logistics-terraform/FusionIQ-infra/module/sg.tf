module "security_group" {
  source     = "../terraform-sg"
  sg_name    = var.sg_name
  from_port  = var.from_port
  to_port    = var.to_port
  vpc_id     = module.fusioniq_vpc.vpc_id
  region     = var.region
  depends_on = [module.fusioniq_vpc]
}
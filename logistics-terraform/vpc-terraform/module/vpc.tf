module "logstic_vpc" {

  source                      = "../terraform-vpc"
  cidr_block                  = var.cidr_block
  enable_dns_hostnames        = var.enable_dns_hostnames
  tags_common                 = var.tags_common
  project                     = var.project
  environment                 = var.environment
  region                      = var.region
  subnet_public               = var.subnet_public
  subnet_public_tag           = var.subnet_public_tag
  subnet_private              = var.subnet_private
  subnet_private_tag          = var.subnet_private_tag
  subnet_private_database     = var.subnet_private_database
  subnet_private_database_tag = var.subnet_private_database_tag

}

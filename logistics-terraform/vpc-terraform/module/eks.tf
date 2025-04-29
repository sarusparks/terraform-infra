module "eks" {
  source = "../../eks"
 
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.logstic_vpc.vpc_id
  subnet_ids      = module.logstic_vpc.subnet_private
  node_groups     = var.node_groups
}

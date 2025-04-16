module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = "fusioniq-cluster"
  cluster_version = "1.31"

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }

  vpc_id                   = module.fusioniq_vpc.vpc_id
  subnet_ids               = slice(module.fusioniq_vpc.subnet_private, 0, 2)
  control_plane_subnet_ids = slice(module.fusioniq_vpc.subnet_private, 0, 2)

  create_cluster_security_group = false
  cluster_security_group_id     = module.security_group.sg_id[0]

  create_node_security_group = false
  node_security_group_id     = module.security_group.sg_id[0]

  eks_managed_node_group_defaults = {
    instance_types = ["t3a.medium"]
    disk_size      = 10
  }

  eks_managed_node_groups = {
    fusioniq_nodes = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3a.medium"]
      capacity_type  = "SPOT"
      disk_size      = 10
      min_size       = 2
      max_size       = 10
      desired_size   = 2
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
        ElasticLoadBalancingFullAccess    = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
        # AmazonEKSClusterPolicy = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
        # AmazonEKSServicePolicy = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
      }
    }
  }

  enable_cluster_creator_admin_permissions = true
  create_cloudwatch_log_group              = false

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

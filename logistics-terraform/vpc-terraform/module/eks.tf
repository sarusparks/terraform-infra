module "eks" {

  source = "terraform-aws-modules/eks/aws"
 
  cluster_name    = "logistics-cluster"

  cluster_version = "1.31"
 
  cluster_endpoint_public_access = true

  cluster_endpoint_private_access = false
 
  cluster_addons = {

    coredns    = { addon_version = "1.8.7-eksbuild.1" }

    kube-proxy = { addon_version = "1.21.2-eksbuild.2" }

    vpc-cni    = { addon_version = "1.11.4-eksbuild.1" }

  }
 
  vpc_id                   = module.logstic_vpc.vpc_id

  subnet_ids               = slice(module.logstic_vpc.subnet_private, 0, 2)

  control_plane_subnet_ids = slice(module.logstic_vpc.subnet_private, 0, 2)
 
  create_cluster_security_group = false

  cluster_security_group_id     = module.security_group.sg_id[0]
 
  create_node_security_group = false

  node_security_group_id     = module.security_group.sg_id[1]
 
  eks_managed_node_group_defaults = {

    instance_types = ["t3a.medium"]

    disk_size      = 20

  }
 
  eks_managed_node_groups = {

    logistics_nodes = {

      ami_type       = "AL2023_x86_64_STANDARD"

      instance_types = ["t3a.medium"]

      capacity_type  = "SPOT"

      disk_size      = 20

      min_size       = 2

      max_size       = 10

      desired_size   = 2

      iam_role_additional_policies = {

        AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"

        AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"

        ElasticLoadBalancingFullAccess    = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"

        AmazonEKSWorkerNodePolicy         = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

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

 

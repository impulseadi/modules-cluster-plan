# VPC
module "vpc" {
  source              = "./modules/vpc"
  cluster_name        = var.cluster_name
  vpc_cidr            = var.vpc_cidr
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  availability_zones  = var.availability_zones
}

# VPC Endpoints
module "vpc_endpoints" {
  source       = "./modules/vpc_endpoints"
  cluster_name = var.cluster_name
  aws_region   = var.aws_region
  vpc_id       = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  route_table_ids    = module.vpc.route_table_ids
  vpc_cidr     = var.vpc_cidr
}

# IAM Roles
module "iam" {
  source       = "./modules/iam"
  cluster_name = var.cluster_name
}

# Security Groups
module "security_groups" {
  source       = "./modules/security_groups"
  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  vpc_cidr     = var.vpc_cidr
}

# EKS Cluster
# module "eks" {
#   source                   = "./modules/eks"
#   cluster_name             = var.cluster_name
#   cluster_version          = var.cluster_version
#   aws_region               = var.aws_region
#   private_subnet_ids       = module.vpc.private_subnet_ids
#   node_group_instance_types = var.node_group_instance_types
#   node_group_desired       = var.node_group_desired
#   node_group_min           = var.node_group_min
#   node_group_max           = var.node_group_max
#   eks_cluster_role_arn     = module.iam.eks_cluster_role_arn
#   node_group_role_arn      = module.iam.node_group_role_arn
# }
module "eks" {
  source                     = "./modules/eks"
  cluster_name               = var.cluster_name
  cluster_version            = var.cluster_version
  aws_region                 = var.aws_region
  private_subnet_ids         = module.vpc.private_subnet_ids
  node_group_instance_types  = var.node_group_instance_types
  node_group_desired         = var.node_group_desired
  node_group_min             = var.node_group_min
  node_group_max             = var.node_group_max

  # Critical: names must match what the module expects
  cluster_role_arn           = module.iam.eks_cluster_role_arn
  node_role_arn              = module.iam.node_group_role_arn
  cluster_role_policy_attachments = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  ]
}


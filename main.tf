# VPC
module "vpc" {
  source                   = "./modules/vpc"
  cluster_name             = var.cluster_name
  vpc_cidr                 = var.vpc_cidr
  public_subnets_cidrs     = var.public_subnets_cidrs
  private_subnets_cidrs    = var.private_subnets_cidrs
  availability_zones       = var.availability_zones
  vpc_enable_dns_support   = var.vpc_enable_dns_support
  vpc_enable_dns_hostnames = var.vpc_enable_dns_hostnames
  map_public_ip_on_launch  = var.map_public_ip_on_launch
  public_route_cidr_blocks = var.public_route_cidr_blocks
}


# VPC Endpoints

module "vpc_endpoints" {
  source = "./modules/vpc_endpoints"  # Path to your module

  cluster_name       = var.cluster_name
  aws_region         = var.aws_region
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  route_table_ids    = var.route_table_ids
  vpc_cidr           = var.vpc_cidr

  sg_ingress_from_port = var.sg_ingress_from_port
  sg_ingress_to_port   = var.sg_ingress_to_port
  sg_ingress_protocol  = var.sg_ingress_protocol
  sg_ingress_cidr      = var.sg_ingress_cidr

  sg_egress_from_port  = var.sg_egress_from_port
  sg_egress_to_port    = var.sg_egress_to_port
  sg_egress_protocol   = var.sg_egress_protocol
  sg_egress_cidr       = var.sg_egress_cidr

  s3_service_name      = var.s3_service_name
  interface_endpoints  = var.interface_endpoints
}



# IAM Roles
module "iam" {
  source       = "./modules/iam"
  cluster_name = var.cluster_name
  aws_region   = var.aws_region
}


# Security Groups
module "security_groups" {
  source                 = "./modules/security_groups"
  cluster_name           = var.cluster_name
  vpc_id                 = module.vpc.vpc_id
  vpc_cidr               = var.vpc_cidr
  intra_node_protocol    = var.intra_node_protocol
  control_plane_port     = var.control_plane_port
  control_plane_protocol = var.control_plane_protocol
  egress_from_port       = var.egress_from_port
  egress_to_port         = var.egress_to_port
  egress_protocol        = var.egress_protocol
  egress_cidr_blocks     = var.egress_cidr_blocks
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

  cluster_role_arn               = module.iam.eks_cluster_role_arn
  node_role_arn                  = module.iam.node_group_role_arn
  cluster_role_policy_attachments = var.cluster_role_policy_attachments

  endpoint_public_access  = var.endpoint_public_access
  endpoint_private_access = var.endpoint_private_access
  public_access_cidrs     = var.public_access_cidrs
  enabled_cluster_log_types = var.enabled_cluster_log_types

  ami_type = var.ami_type
}

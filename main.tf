module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = var.vpc_cidr
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  availability_zones    = var.availability_zones
  cluster_name          = var.cluster_name
  enable_dns_hostnames  = var.enable_dns_hostnames
  enable_dns_support    = var.enable_dns_support
  public_route_cidr     = var.public_route_cidr
  private_route_cidr    = var.private_route_cidr
  bastion_ingress_rules = var.bastion_ingress_rules
  bastion_egress_rules  = var.bastion_egress_rules
  bastion_instance_type = var.bastion_instance_type
  bastion_ami           = var.bastion_ami
  bastion_key_name      = var.bastion_key_name
  aws_region            = var.aws_region
}


module "security_groups" {
  source                   = "./modules/security_groups"
  cluster_name             = var.cluster_name
  vpc_cidr                 = var.vpc_cidr
  vpc_id                   = module.vpc.vpc_id
  sg_name                  = var.sg_name
  sg_description           = var.sg_description
  ingress_self_protocol    = var.sg_ingress_self_protocol
  ingress_self_from_port   = var.sg_ingress_self_from_port
  ingress_self_to_port     = var.sg_ingress_self_to_port
  ingress_self_self        = var.sg_ingress_self_self
  ingress_self_description = var.sg_ingress_self_description
  ingress_cp_protocol      = var.sg_ingress_cp_protocol
  ingress_cp_from_port     = var.sg_ingress_cp_from_port
  ingress_cp_to_port       = var.sg_ingress_cp_to_port
  ingress_cp_cidr_blocks   = [var.vpc_cidr] # Use VPC CIDR for control plane access
  ingress_cp_description   = var.sg_ingress_cp_description
  egress_from_port         = var.sg_egress_from_port
  egress_to_port           = var.sg_egress_to_port
  egress_protocol          = var.sg_egress_protocol
  egress_cidr_blocks       = var.sg_egress_cidr_blocks
  tags                     = var.tags
}

module "iam" {
  source               = "./modules/iam"
  cluster_name         = var.cluster_name
  eks_cluster_policies = var.eks_cluster_policies
  eks_node_policies    = var.eks_node_policies
}

module "eks" {
  source                      = "./modules/eks"
  cluster_name                = var.cluster_name
  cluster_version             = var.cluster_version
  cluster_role_arn            = module.iam.eks_cluster_role_arn
  node_group_role_arn         = module.iam.node_group_role_arn
  private_subnets_ids         = module.vpc.private_subnet_ids
  node_group_instance_types   = var.node_group_instance_types
  node_group_desired          = var.node_group_desired
  node_group_min              = var.node_group_min
  node_group_max              = var.node_group_max
  aws_region                  = var.aws_region
  endpoint_private_access     = var.endpoint_private_access
  endpoint_public_access      = var.endpoint_public_access
  public_access_cidrs         = var.public_access_cidrs
  enabled_cluster_log_types   = var.enabled_cluster_log_types
  tags                        = var.tags
  ec2_ssh_key                 = var.ec2_ssh_key
  ami_type                    = var.ami_type
  node_group_tags             = var.node_group_tags
}

module "vpc_endpoints" {
  source                      = "./modules/vpc_endpoints"
  cluster_name                = var.cluster_name
  vpc_id                      = module.vpc.vpc_id
  aws_region                  = var.aws_region
  route_table_private_id      = module.vpc.private_route_table_id
  route_table_public_id       = module.vpc.public_route_table_id
  private_subnets_ids         = module.vpc.private_subnet_ids
  interface_endpoints         = var.interface_endpoints
  ingress_from_port           = var.vpce_ingress_from_port
  ingress_to_port             = var.vpce_ingress_to_port
  ingress_protocol            = var.vpce_ingress_protocol
  ingress_cidr_blocks         = [var.vpc_cidr] # Use VPC CIDR for endpoint access
  egress_from_port            = var.vpce_egress_from_port
  egress_to_port              = var.vpce_egress_to_port
  egress_protocol             = var.vpce_egress_protocol
  egress_cidr_blocks          = var.vpce_egress_cidr_blocks
  endpoints_sg_name           = var.vpce_sg_name
  endpoints_sg_description    = var.vpce_sg_description
  s3_service_name             = var.s3_service_name
  s3_vpc_endpoint_type        = var.s3_vpc_endpoint_type
  interface_vpc_endpoint_type = var.interface_vpc_endpoint_type
  private_dns_enabled         = var.private_dns_enabled
}
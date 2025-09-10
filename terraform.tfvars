# General EKS cluster variables

aws_region                = "us-east-1"
cluster_name              = "my-eks-cluster"
vpc_id                    = ""  # Leave empty if creating a new VPC
vpc_cidr                  = "10.0.0.0/16"
public_subnets_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidrs     = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones        = ["us-east-1a", "us-east-1b"]
node_group_instance_types = ["t3.medium"]
node_group_desired        = 2
node_group_min            = 1
node_group_max            = 3
cluster_version           = "1.27"


# Security Group variables

intra_node_protocol       = "tcp"
control_plane_port        = 443
control_plane_protocol    = "tcp"
egress_from_port          = 0
egress_to_port            = 0
egress_protocol           = "-1"
egress_cidr_blocks        = ["0.0.0.0/0"]


# Cluster endpoint and logging variables

endpoint_public_access    = true
endpoint_private_access   = false
public_access_cidrs       = ["0.0.0.0/0"]
enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]


# Node group AMI & IAM

ami_type                                 = "AL2_x86_64"
cluster_role_policy_attachments          = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
                                             "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"]
eks_assume_role_principal_type           = "Service"
eks_assume_role_principal_identifiers    = ["eks.amazonaws.com"]
node_assume_role_principal_type          = "Service"
node_assume_role_principal_identifiers   = ["ec2.amazonaws.com"]

# VPC settings

vpc_enable_dns_support      = true
vpc_enable_dns_hostnames    = true
map_public_ip_on_launch     = true
public_route_cidr_blocks    = ["0.0.0.0/0"]


# VPC Endpoint variables

s3_route_table_ids          = [] # Fill with your public/private route table IDs if needed
s3_service_name             = "s3"
private_subnet_ids          = [] # Fill with private subnet IDs
route_table_ids             = [] # Fill with route table IDs for interface endpoints
interface_endpoints         = ["ec2", "ecr.api", "ecr.dkr", "ssm", "kms", "logs"]
sg_ingress_from_port        = 443
sg_ingress_to_port          = 443
sg_ingress_protocol         = "tcp"
sg_ingress_cidr             = "0.0.0.0/0"
sg_egress_from_port         = 0
sg_egress_to_port           = 0
sg_egress_protocol          = "-1"
sg_egress_cidr              = ["0.0.0.0/0"]

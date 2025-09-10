
# General Configuration

aws_region   = "eu-west-3"
cluster_name = "private-eks-adi"
tags = {
  Owner       = "Adi"
  Project     = "PrivateEKS"
  ManagedBy   = "Terraform"
}


# VPC Configuration

vpc_cidr              = "10.20.0.0/16"
public_subnets_cidrs  = ["10.20.1.0/24", "10.20.2.0/24"]
private_subnets_cidrs = ["10.20.10.0/24", "10.20.11.0/24"]
availability_zones    = ["eu-west-3a", "eu-west-3b"]
enable_dns_hostnames  = true
enable_dns_support    = true
public_route_cidr     = "0.0.0.0/0"
private_route_cidr    = "0.0.0.0/0"


# EKS Cluster Configuration

cluster_version           = "1.28"
endpoint_private_access   = true
endpoint_public_access    = false
public_access_cidrs       = ["0.0.0.0/0"]
enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]


# EKS Node Group Configuration

node_group_instance_types = ["t3.medium"]
node_group_desired        = 2
node_group_min            = 1
node_group_max            = 3
ec2_ssh_key               = "" # Add your key name here to enable SSH, e.g., "my-key"
ami_type                  = "AL2_x86_64"
node_group_tags = {
  "k8s.io/cluster-autoscaler/enabled" : "true",
  "k8s.io/cluster-autoscaler/private-eks-adi" : "owned"
}


# IAM Configuration

eks_cluster_policies = [
  "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
]
eks_node_policies = [
  "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" # Optional: for SSM access
]


# Worker Node Security Group (sg_*)

sg_name                   = "eks-worker-nodes-sg"
sg_description            = "Security group for EKS worker nodes"
sg_ingress_self_protocol    = "-1" # All protocols
sg_ingress_self_from_port   = 0
sg_ingress_self_to_port     = 0
sg_ingress_self_self        = true
sg_ingress_self_description = "Allow nodes to communicate with each other"
sg_ingress_cp_protocol      = "tcp"
sg_ingress_cp_from_port     = 443
sg_ingress_cp_to_port       = 443
sg_ingress_cp_description   = "Allow worker nodes to communicate with the control plane"
sg_egress_from_port         = 0
sg_egress_to_port           = 0
sg_egress_protocol          = "-1"
sg_egress_cidr_blocks       = ["0.0.0.0/0"]


# VPC Endpoints Configuration (vpce_*)

interface_endpoints         = ["ecr.api", "ecr.dkr", "sts", "logs", "ec2"]
vpce_ingress_from_port      = 443
vpce_ingress_to_port        = 443
vpce_ingress_protocol       = "tcp"
vpce_egress_from_port       = 0
vpce_egress_to_port         = 0
vpce_egress_protocol        = "-1"
vpce_egress_cidr_blocks     = ["0.0.0.0/0"]
vpce_sg_name                = "eks-vpc-endpoints-sg"
vpce_sg_description         = "Security group for VPC interface endpoints"
s3_service_name             = "s3"
s3_vpc_endpoint_type        = "Gateway"
interface_vpc_endpoint_type = "Interface"
private_dns_enabled         = true


# ----------------------------------------------------------------------------- 
# Bastion Host Configuration
# -----------------------------------------------------------------------------
bastion_instance_type = "t2.micro"
bastion_ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 in eu-west-3
bastion_key_name      = "my-keypair"            # must exist in AWS

bastion_ingress_rules = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # replace with your own public IP
  }
]

bastion_egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
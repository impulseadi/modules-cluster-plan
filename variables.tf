# ---------------------------
# General EKS cluster variables
# ---------------------------
variable "aws_region" {
  type        = string
  description = "AWS region for the EKS cluster"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "vpc_id" {
  type        = string
  description = "ID of the existing VPC to deploy the EKS cluster into (optional if creating a new VPC)"
  default     = ""
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "CIDR blocks for the public subnets"
}

variable "private_subnets_cidrs" {
  type        = list(string)
  description = "CIDR blocks for the private subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones to use"
}

variable "node_group_instance_types" {
  type        = list(string)
  description = "EC2 instance types for EKS node group"
}

variable "node_group_desired" {
  type        = number
  description = "Desired size of the node group"
}

variable "node_group_min" {
  type        = number
  description = "Minimum size of the node group"
}

variable "node_group_max" {
  type        = number
  description = "Maximum size of the node group"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
}

# ---------------------------
# Security Group variables
# ---------------------------
variable "intra_node_protocol" {
  type        = string
  description = "Protocol for intra-node communication"
}

variable "control_plane_port" {
  type        = number
  description = "Port used for communication with the EKS control plane"
}

variable "control_plane_protocol" {
  type        = string
  description = "Protocol used for communication with the EKS control plane"
}

variable "egress_from_port" {
  type        = number
  description = "From port for egress rules"
}

variable "egress_to_port" {
  type        = number
  description = "To port for egress rules"
}

variable "egress_protocol" {
  type        = string
  description = "Protocol for egress rules"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks allowed for egress"
}

# ---------------------------
# Cluster endpoint and logging variables
# ---------------------------
variable "endpoint_public_access" {
  type        = bool
  description = "Whether the cluster API server endpoint is publicly accessible"
}

variable "endpoint_private_access" {
  type        = bool
  description = "Whether the cluster API server endpoint is privately accessible"
}

variable "public_access_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks allowed to access the public endpoint"
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "List of EKS control plane log types to enable"
}

# ---------------------------
# Node group AMI & IAM
# ---------------------------
variable "ami_type" {
  type        = string
  description = "AMI type for EKS worker nodes"
}

variable "cluster_role_policy_attachments" {
  type        = list(string)
  description = "List of IAM policies to attach to the EKS cluster role"
}

variable "eks_assume_role_principal_type" {
  type        = string
  description = "Principal type for EKS cluster IAM role"
}

variable "eks_assume_role_principal_identifiers" {
  type        = list(string)
  description = "Principal identifiers for EKS cluster IAM role"
}

variable "node_assume_role_principal_type" {
  type        = string
  description = "Principal type for EKS node group IAM role"
}

variable "node_assume_role_principal_identifiers" {
  type        = list(string)
  description = "Principal identifiers for EKS node group IAM role"
}

# ---------------------------
# VPC settings
# ---------------------------
variable "vpc_enable_dns_support" {
  type    = bool
  default = true
}

variable "vpc_enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = true
}

variable "public_route_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

# ---------------------------
# VPC Endpoint variables
# ---------------------------
variable "s3_route_table_ids" {
  type        = list(string)
  description = "List of route table IDs for the S3 Gateway endpoint"
}

variable "s3_service_name" {
  type        = string
  description = "S3 service name for the VPC endpoint"
  default     = "s3"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for interface endpoints"
}

variable "route_table_ids" {
  type        = list(string)
  description = "List of route table IDs for interface endpoints"
}

variable "interface_endpoints" {
  type        = list(string)
  description = "List of interface VPC endpoints to create"
}

variable "sg_ingress_from_port" {
  type        = number
  description = "Ingress from port for the VPC endpoint security group"
}

variable "sg_ingress_to_port" {
  type        = number
  description = "Ingress to port for the VPC endpoint security group"
}

variable "sg_ingress_protocol" {
  type        = string
  description = "Ingress protocol for the VPC endpoint security group"
}

variable "sg_ingress_cidr" {
  type        = string
  description = "Ingress CIDR for the VPC endpoint security group"
}

variable "sg_egress_from_port" {
  type        = number
  description = "Egress from port for the VPC endpoint security group"
}

variable "sg_egress_to_port" {
  type        = number
  description = "Egress to port for the VPC endpoint security group"
}

variable "sg_egress_protocol" {
  type        = string
  description = "Egress protocol for the VPC endpoint security group"
}

variable "sg_egress_cidr" {
  type        = list(string)
  description = "Egress CIDRs for the VPC endpoint security group"
}

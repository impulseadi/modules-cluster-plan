#------------------------------------------------------------------------------
# General Configuration
#------------------------------------------------------------------------------
variable "aws_region" {
  description = "The AWS region to deploy all resources."
  type        = string
}

variable "cluster_name" {
  description = "The name for the EKS cluster and a prefix for related resources."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all taggable resources."
  type        = map(string)
}

#------------------------------------------------------------------------------
# VPC Configuration
#------------------------------------------------------------------------------
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnets_cidrs" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
}

variable "private_subnets_cidrs" {
  description = "A list of CIDR blocks for the private subnets."
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of Availability Zones to use. Leave empty to auto-select."
  type        = list(string)
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC."
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC."
  type        = bool
}

variable "public_route_cidr" {
  description = "Destination CIDR for the public route table (e.g., 0.0.0.0/0)."
  type        = string
}

variable "private_route_cidr" {
  description = "Destination CIDR for the private route table (e.g., 0.0.0.0/0)."
  type        = string
}

#------------------------------------------------------------------------------
# EKS Cluster Configuration
#------------------------------------------------------------------------------
variable "cluster_version" {
  description = "The Kubernetes version for the EKS cluster."
  type        = string
}

variable "endpoint_private_access" {
  description = "Enable the private API server endpoint for the EKS cluster."
  type        = bool
}

variable "endpoint_public_access" {
  description = "Enable the public API server endpoint for the EKS cluster."
  type        = bool
}

variable "public_access_cidrs" {
  description = "CIDR blocks that can access the public EKS endpoint."
  type        = list(string)
}

variable "enabled_cluster_log_types" {
  description = "A list of log types to enable for the EKS cluster (e.g., 'api', 'audit')."
  type        = list(string)
}

#------------------------------------------------------------------------------
# EKS Node Group Configuration
#------------------------------------------------------------------------------
variable "node_group_instance_types" {
  description = "A list of instance types for the EKS worker nodes."
  type        = list(string)
}

variable "node_group_desired" {
  description = "Desired number of worker nodes."
  type        = number
}

variable "node_group_min" {
  description = "Minimum number of worker nodes."
  type        = number
}

variable "node_group_max" {
  description = "Maximum number of worker nodes."
  type        = number
}

variable "ec2_ssh_key" {
  description = "The name of the EC2 key pair to allow SSH access to the nodes. Set to empty string to disable."
  type        = string
}

variable "ami_type" {
  description = "The AMI type for the EKS node group (e.g., 'AL2_x86_64')."
  type        = string
}

variable "node_group_tags" {
  description = "A map of tags to apply specifically to the EKS node group."
  type        = map(string)
}

#------------------------------------------------------------------------------
# IAM Configuration
#------------------------------------------------------------------------------
variable "eks_cluster_policies" {
  description = "A list of IAM policy ARNs to attach to the EKS cluster role."
  type        = list(string)
}

variable "eks_node_policies" {
  description = "A list of IAM policy ARNs to attach to the EKS node group role."
  type        = list(string)
}

#------------------------------------------------------------------------------
# Worker Node Security Group (sg_*)
#------------------------------------------------------------------------------
variable "sg_name" {
  description = "The name for the worker node security group."
  type        = string
}

variable "sg_description" {
  description = "The description for the worker node security group."
  type        = string
}

variable "sg_ingress_self_protocol" {
  description = "Protocol for intra-node communication rule."
  type        = string
}

variable "sg_ingress_self_from_port" {
  description = "Start port for intra-node communication rule."
  type        = number
}

variable "sg_ingress_self_to_port" {
  description = "End port for intra-node communication rule."
  type        = number
}

variable "sg_ingress_self_self" {
  description = "Set to true for self-referencing ingress rule."
  type        = bool
}

variable "sg_ingress_self_description" {
  description = "Description for the self-referencing ingress rule."
  type        = string
}

variable "sg_ingress_cp_protocol" {
  description = "Protocol for node-to-control-plane communication rule."
  type        = string
}

variable "sg_ingress_cp_from_port" {
  description = "Start port for node-to-control-plane communication rule."
  type        = number
}

variable "sg_ingress_cp_to_port" {
  description = "End port for node-to-control-plane communication rule."
  type        = number
}

variable "sg_ingress_cp_description" {
  description = "Description for the node-to-control-plane ingress rule."
  type        = string
}

variable "sg_egress_from_port" {
  description = "Start port for the worker node egress rule."
  type        = number
}

variable "sg_egress_to_port" {
  description = "End port for the worker node egress rule."
  type        = number
}

variable "sg_egress_protocol" {
  description = "Protocol for the worker node egress rule."
  type        = string
}

variable "sg_egress_cidr_blocks" {
  description = "Destination CIDR blocks for the worker node egress rule."
  type        = list(string)
}

#------------------------------------------------------------------------------
# VPC Endpoints Configuration (vpce_*)
#------------------------------------------------------------------------------
variable "interface_endpoints" {
  description = "A list of services for which to create VPC interface endpoints (e.g., 'ecr.api')."
  type        = list(string)
}

variable "vpce_ingress_from_port" {
  description = "Start port for the VPC endpoint security group ingress rule."
  type        = number
}

variable "vpce_ingress_to_port" {
  description = "End port for the VPC endpoint security group ingress rule."
  type        = number
}

variable "vpce_ingress_protocol" {
  description = "Protocol for the VPC endpoint security group ingress rule."
  type        = string
}

variable "vpce_egress_from_port" {
  description = "Start port for the VPC endpoint security group egress rule."
  type        = number
}

variable "vpce_egress_to_port" {
  description = "End port for the VPC endpoint security group egress rule."
  type        = number
}

variable "vpce_egress_protocol" {
  description = "Protocol for the VPC endpoint security group egress rule."
  type        = string
}

variable "vpce_egress_cidr_blocks" {
  description = "Destination CIDR blocks for the VPC endpoint security group egress rule."
  type        = list(string)
}

variable "vpce_sg_name" {
  description = "The name for the VPC endpoint security group."
  type        = string
}

variable "vpce_sg_description" {
  description = "The description for the VPC endpoint security group."
  type        = string
}

variable "s3_service_name" {
  description = "Service name for the S3 gateway endpoint (usually 's3')."
  type        = string
}

variable "s3_vpc_endpoint_type" {
  description = "Endpoint type for S3 (usually 'Gateway')."
  type        = string
}

variable "interface_vpc_endpoint_type" {
  description = "Endpoint type for interfaces (usually 'Interface')."
  type        = string
}

variable "private_dns_enabled" {
  description = "Enable private DNS for VPC interface endpoints."
  type        = bool
}

variable "bastion_ingress_rules" {
  description = "List of ingress rules for bastion security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "bastion_egress_rules" {
  description = "List of egress rules for bastion security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "bastion_instance_type" {
  description = "EC2 instance type for the bastion host"
  type        = string
  default     = "t2.micro"
}

variable "bastion_ami" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "bastion_key_name" {
  description = "SSH key name for bastion host (must exist in AWS)"
  type        = string
}
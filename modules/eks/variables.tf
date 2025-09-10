variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy the cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  type        = string
}

variable "cluster_role_policy_attachments" {
  description = "List of cluster role policy attachments to wait on"
  type        = list(any)
}

variable "node_role_arn" {
  description = "IAM role ARN for EKS node group"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for EKS cluster and nodes"
  type        = list(string)
}

variable "node_group_desired" {
  description = "Desired size of node group"
  type        = number
}

variable "node_group_min" {
  description = "Minimum size of node group"
  type        = number
}

variable "node_group_max" {
  description = "Maximum size of node group"
  type        = number
}

variable "node_group_instance_types" {
  description = "EC2 instance types for node group"
  type        = list(string)
}

# New variables for previously hardcoded values
variable "enabled_cluster_log_types" {
  description = "List of EKS control plane log types to enable"
  type        = list(string)
}

variable "endpoint_private_access" {
  description = "Enable private access to EKS API server"
  type        = bool
}

variable "endpoint_public_access" {
  description = "Enable public access to EKS API server"
  type        = bool
}

variable "public_access_cidrs" {
  description = "List of CIDRs allowed for public access"
  type        = list(string)
}

variable "ami_type" {
  description = "AMI type for EKS worker nodes"
  type        = string
}

variable "ec2_ssh_key" {
  description = "SSH key pair name for worker nodes"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

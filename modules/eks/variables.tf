variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
  default     = "1.27"
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy the cluster"
  default     = "us-east-1"
}

variable "cluster_role_arn" {
  type        = string
  description = "IAM role ARN for EKS cluster"
}

variable "cluster_role_policy_attachments" {
  type        = list(any)
  description = "List of cluster role policy attachments to wait on"
}

variable "node_role_arn" {
  type        = string
  description = "IAM role ARN for EKS node group"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for EKS cluster and nodes"
}

variable "node_group_desired" {
  type        = number
  description = "Desired size of node group"
  default     = 2
}

variable "node_group_min" {
  type        = number
  description = "Minimum size of node group"
  default     = 1
}

variable "node_group_max" {
  type        = number
  description = "Maximum size of node group"
  default     = 3
}

variable "node_group_instance_types" {
  type        = list(string)
  description = "EC2 instance types for node group"
  default     = ["t3.medium"]
}

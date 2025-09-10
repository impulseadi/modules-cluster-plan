# Name of the EKS cluster
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

# AWS region (passed from root module)
variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
}
variable "eks_assume_role_principal_type" {
  description = "Type of principal for EKS cluster assume role"
  type        = string
  default     = "Service"
}

variable "eks_assume_role_principal_identifiers" {
  description = "List of identifiers for EKS cluster assume role"
  type        = list(string)
  default     = ["eks.amazonaws.com"]
}

variable "node_assume_role_principal_type" {
  description = "Type of principal for node group assume role"
  type        = string
  default     = "Service"
}

variable "node_assume_role_principal_identifiers" {
  description = "List of identifiers for node group assume role"
  type        = list(string)
  default     = ["ec2.amazonaws.com"]
}


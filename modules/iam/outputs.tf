# Name of the EKS cluster
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

# Optional: AWS region (if needed in this module, currently not used)
variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

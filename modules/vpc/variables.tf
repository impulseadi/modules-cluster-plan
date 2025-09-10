variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "List of CIDRs for public subnets"
}

variable "private_subnets_cidrs" {
  type        = list(string)
  description = "List of CIDRs for private subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of AZs for subnets"
}

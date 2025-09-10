variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the security group will be created"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the VPC"
}

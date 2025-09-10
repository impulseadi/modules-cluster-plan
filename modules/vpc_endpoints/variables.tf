variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where endpoints will be created"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for interface endpoints"
}

variable "route_table_ids" {
  type        = list(string)
  description = "List of route table IDs for the S3 gateway endpoint"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the VPC for security group ingress"
}

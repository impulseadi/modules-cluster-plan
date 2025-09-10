# ---------------------------
# Core Variables
# ---------------------------
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

# ---------------------------
# Security Group Variables
# ---------------------------
variable "sg_ingress_from_port" {
  type        = number
  description = "Ingress start port for security group"
}

variable "sg_ingress_to_port" {
  type        = number
  description = "Ingress end port for security group"
}

variable "sg_ingress_protocol" {
  type        = string
  description = "Ingress protocol for security group"
}

variable "sg_ingress_cidr" {
  type        = string
  description = "Ingress CIDR for security group"
}

variable "sg_egress_from_port" {
  type        = number
  description = "Egress start port for security group"
}

variable "sg_egress_to_port" {
  type        = number
  description = "Egress end port for security group"
}

variable "sg_egress_protocol" {
  type        = string
  description = "Egress protocol for security group"
}

variable "sg_egress_cidr" {
  type        = list(string)
  description = "Egress CIDR blocks for security group"
}

# ---------------------------
# S3 Gateway Endpoint Variables
# ---------------------------
variable "s3_service_name" {
  type        = string
  description = "AWS service name for the S3 gateway endpoint"
  default     = "s3"
}

# ---------------------------
# Interface Endpoint Variables
# ---------------------------
variable "interface_endpoints" {
  type        = list(string)
  description = "List of interface endpoints to create (e.g., ecr.api, ecr.dkr, sts, logs, ec2)"
}

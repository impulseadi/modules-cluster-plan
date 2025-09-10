variable "cluster_name" {
  description = "A name prefix used for tagging and naming resources."
  type        = string
}

variable "aws_region" {
  description = "The AWS region where the resources will be created."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the endpoints will be created."
  type        = string
}

variable "private_subnets_ids" {
  description = "A list of private subnet IDs for the interface endpoints."
  type        = list(string)
}

variable "route_table_private_id" {
  description = "The ID of the private route table to associate with the S3 gateway endpoint."
  type        = string
}

variable "route_table_public_id" {
  description = "The ID of the public route table to associate with the S3 gateway endpoint."
  type        = string
}

variable "s3_service_name" {
  description = "The service name for the S3 endpoint (typically 's3')."
  type        = string
}

variable "s3_vpc_endpoint_type" {
  description = "The type of VPC endpoint for S3 (typically 'Gateway')."
  type        = string
}

variable "interface_endpoints" {
  description = "A list of service names for which to create interface endpoints (e.g., 'ecr.api', 'sts')."
  type        = list(string)
}

variable "interface_vpc_endpoint_type" {
  description = "The type of VPC endpoint for the interfaces (typically 'Interface')."
  type        = string
}

variable "private_dns_enabled" {
  description = "Whether to enable private DNS for the interface endpoints."
  type        = bool
}

variable "endpoints_sg_name" {
  description = "The name for the security group associated with the interface endpoints."
  type        = string
}

variable "endpoints_sg_description" {
  description = "The description for the interface endpoints security group."
  type        = string
}

variable "ingress_from_port" {
  description = "The start port for the security group's ingress rule."
  type        = number
}

variable "ingress_to_port" {
  description = "The end port for the security group's ingress rule."
  type        = number
}

variable "ingress_protocol" {
  description = "The protocol for the security group's ingress rule."
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "The list of source CIDR blocks for the ingress rule."
  type        = list(string)
}

variable "egress_from_port" {
  description = "The start port for the security group's egress rule."
  type        = number
}

variable "egress_to_port" {
  description = "The end port for the security group's egress rule."
  type        = number
}

variable "egress_protocol" {
  description = "The protocol for the security group's egress rule."
  type        = string
}

variable "egress_cidr_blocks" {
  description = "The list of destination CIDR blocks for the egress rule."
  type        = list(string)
}
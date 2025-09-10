variable "cluster_name" {
  description = "Name prefix for all resources in this VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "vpc_enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "availability_zones" {
  description = "List of availability zones to deploy subnets"
  type        = list(string)
}

variable "public_subnets_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnets_cidrs" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
}

variable "map_public_ip_on_launch" {
  description = "Whether to auto-assign public IPs for public subnets"
  type        = bool
  default     = true
}

variable "public_route_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for public routes (usually 0.0.0.0/0)"
  default     = ["0.0.0.0/0"]
}

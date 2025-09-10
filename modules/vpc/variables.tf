# ==========================
# Core VPC Variables
# ==========================
variable "cluster_name" {
  description = "A name prefix used for tagging and naming VPC resources."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "A list of Availability Zones to use for the subnets. If empty, the module will auto-select zones."
  type        = list(string)
  default     = []
}

variable "public_subnets_cidrs" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
}

variable "private_subnets_cidrs" {
  description = "A list of CIDR blocks for the private subnets."
  type        = list(string)
}

variable "enable_dns_hostnames" {
  description = "Enable/disable DNS hostnames in the VPC."
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable/disable DNS support in the VPC."
  type        = bool
}

variable "public_route_cidr" {
  description = "Destination CIDR block for the public route table (e.g., 0.0.0.0/0)."
  type        = string
}

variable "private_route_cidr" {
  description = "Destination CIDR block for the private route table (e.g., 0.0.0.0/0)."
  type        = string
}

# ==========================
# VPC Endpoint Variables
# ==========================
variable "aws_region" {
  description = "AWS region for endpoints"
  type        = string
}

variable "s3_service_name" {
  description = "Service name for S3 endpoint (default: s3)"
  type        = string
  default     = "s3"
}

variable "s3_vpc_endpoint_type" {
  description = "Type of S3 VPC endpoint (Gateway or Interface)"
  type        = string
  default     = "Gateway"
}

variable "interface_endpoints" {
  description = "List of interface endpoints to create (e.g., ec2, ecr.api, ecr.dkr, ssm, kms, logs)"
  type        = list(string)
  default     = []
}

variable "interface_vpc_endpoint_type" {
  description = "Type of interface endpoints (usually 'Interface')"
  type        = string
  default     = "Interface"
}

variable "private_dns_enabled" {
  description = "Enable private DNS for interface endpoints"
  type        = bool
  default     = true
}

variable "vpce_sg_name" {
  description = "Name for the VPC endpoints security group"
  type        = string
  default     = "vpce-sg"
}

variable "vpce_sg_description" {
  description = "Description for the VPC endpoints security group"
  type        = string
  default     = "Allow access to VPC Endpoints"
}

variable "vpce_ingress_from_port" {
  description = "Ingress starting port for VPC endpoint SG"
  type        = number
  default     = 443
}

variable "vpce_ingress_to_port" {
  description = "Ingress ending port for VPC endpoint SG"
  type        = number
  default     = 443
}

variable "vpce_ingress_protocol" {
  description = "Ingress protocol for VPC endpoint SG"
  type        = string
  default     = "tcp"
}

variable "vpce_ingress_cidr_blocks" {
  description = "Ingress CIDR blocks for VPC endpoint SG"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vpce_egress_from_port" {
  description = "Egress starting port for VPC endpoint SG"
  type        = number
  default     = 0
}

variable "vpce_egress_to_port" {
  description = "Egress ending port for VPC endpoint SG"
  type        = number
  default     = 0
}

variable "vpce_egress_protocol" {
  description = "Egress protocol for VPC endpoint SG"
  type        = string
  default     = "-1"
}

variable "vpce_egress_cidr_blocks" {
  description = "Egress CIDR blocks for VPC endpoint SG"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# ==========================
# Bastion Host Variables
# ==========================
variable "bastion_ingress_rules" {
  description = "List of ingress rules for bastion security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "bastion_egress_rules" {
  description = "List of egress rules for bastion security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "bastion_instance_type" {
  description = "EC2 instance type for the bastion host"
  type        = string
  default     = "t2.micro"
}

variable "bastion_ami" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "bastion_key_name" {
  description = "SSH key name for bastion host (must exist in AWS)"
  type        = string
}

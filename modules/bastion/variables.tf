variable "cluster_name" {
  description = "Cluster name for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where bastion will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to launch bastion into"
  type        = list(string)
}

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
  description = "Instance type for bastion host"
  type        = string
  default     = "t2.micro"
}

variable "bastion_ami" {
  description = "AMI ID for bastion host"
  type        = string
}

variable "bastion_key_name" {
  description = "SSH key name to use for bastion host"
  type        = string
}

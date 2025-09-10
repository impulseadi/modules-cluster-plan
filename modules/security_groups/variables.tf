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

variable "intra_node_protocol" {
  type        = string
  description = "Protocol for intra-node communication"
}

variable "control_plane_port" {
  type        = number
  description = "Port for worker nodes to communicate with control plane"
}

variable "control_plane_protocol" {
  type        = string
  description = "Protocol for control plane communication"
}

variable "egress_from_port" {
  type        = number
  description = "Starting port for egress rules"
}

variable "egress_to_port" {
  type        = number
  description = "Ending port for egress rules"
}

variable "egress_protocol" {
  type        = string
  description = "Protocol for egress rules"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for outbound traffic from worker nodes"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name (used for naming IAM roles)"
}

variable "eks_cluster_policies" {
  type = list(string)
}

variable "eks_node_policies" {
  type = list(string)
}
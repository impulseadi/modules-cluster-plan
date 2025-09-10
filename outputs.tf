output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster's API server."
  value       = module.eks.cluster_endpoint
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "A list of the private subnet IDs."
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "A list of the public subnet IDs."
  value       = module.vpc.public_subnet_ids
}

output "worker_node_sg_id" {
  description = "The ID of the security group for the EKS worker nodes."
  value       = module.security_groups.workers_sg_id
}

output "eks_cluster_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster."
  value       = module.iam.eks_cluster_role_arn
}

output "eks_node_group_role_arn" {
  description = "The ARN of the IAM role for the EKS node group."
  value       = module.iam.node_group_role_arn
}
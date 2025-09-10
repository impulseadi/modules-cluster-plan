# modules/eks/outputs.tf

output "cluster_name" {
  value       = aws_eks_cluster.this.name
  description = "EKS cluster name"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.this.endpoint
  description = "EKS cluster endpoint (private)"
}

output "cluster_certificate_authority_data" {
  value       = aws_eks_cluster.this.certificate_authority[0].data
  description = "EKS cluster CA data"
}

output "cluster_security_group_id" {
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  description = "EKS cluster security group ID"
}

output "node_group_arn" {
  value       = aws_eks_node_group.managed_nodes.arn
  description = "EKS managed node group ARN"
}
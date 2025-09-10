output "cluster_endpoint" {
  value       = aws_eks_cluster.this.endpoint
  description = "EKS cluster endpoint (private)"
}

output "cluster_certificate_authority_data" {
  value       = aws_eks_cluster.this.certificate_authority[0].data
  description = "Cluster certificate authority data"
}

output "cluster_security_group_id" {
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  description = "Security group ID associated with the cluster"
}

output "node_group_arn" {
  value       = aws_eks_node_group.managed_nodes.arn
  description = "ARN of the EKS node group"
}

output "kubeconfig_file" {
  value       = local_file.kubeconfig.filename
  description = "Path to generated kubeconfig file"
}

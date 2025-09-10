output "eks_cluster_role_arn" {
  value       = aws_iam_role.eks_cluster.arn
  description = "IAM role ARN for the EKS cluster"
}

output "node_group_role_arn" {
  value       = aws_iam_role.node_group.arn
  description = "IAM role ARN for the worker node group"
}

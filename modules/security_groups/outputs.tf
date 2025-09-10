# Output the worker security group ID
output "workers_sg_id" {
  description = "The ID of the EKS worker nodes security group"
  value       = aws_security_group.workers.id
}

# Optional: Output the security group name
output "workers_sg_name" {
  description = "The name of the EKS worker nodes security group"
  value       = aws_security_group.workers.name
}

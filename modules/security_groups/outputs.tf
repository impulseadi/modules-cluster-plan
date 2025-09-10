# Optional: Output the security group name
output "workers_sg_name" {
  description = "The name of the EKS worker nodes security group"
  value       = aws_security_group.workers.name
}

output "workers_sg_id" {
  description = "Security Group ID for EKS worker nodes"
  value       = aws_security_group.workers.id
}

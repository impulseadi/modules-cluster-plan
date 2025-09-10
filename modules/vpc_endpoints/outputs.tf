output "s3_endpoint_id" {
  value       = aws_vpc_endpoint.s3.id
  description = "ID of the S3 gateway endpoint"
}

output "interface_endpoint_ids" {
  value       = [for ep in aws_vpc_endpoint.interface_endpoints : ep.id]
  description = "IDs of all interface endpoints"
}

output "endpoints_security_group_id" {
  value       = aws_security_group.endpoints_sg.id
  description = "Security group ID used by interface endpoints"
}

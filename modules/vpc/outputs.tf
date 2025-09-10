output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "IDs of the public subnets"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "IDs of the private subnets"
}

output "route_table_ids" {
  value       = concat(aws_route_table.public[*].id, aws_route_table.private[*].id)
  description = "IDs of all route tables (public + private)"
}

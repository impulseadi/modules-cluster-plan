output "vpc_id" {
  description = "The ID of the created VPC."
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "A list of the IDs of the public subnets."
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "A list of the IDs of the private subnets."
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "availability_zones_used" {
  description = "The list of Availability Zones used by the subnets."
  value       = local.azs
}

output "igw_id" {
  description = "The ID of the Internet Gateway."
  value       = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway."
  value       = aws_nat_gateway.nat.id
}

output "public_route_table_id" {
  description = "The ID of the public route table."
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "The ID of the private route table."
  value       = aws_route_table.private.id
}
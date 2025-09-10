output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "node_group_arn" {
  value = module.eks.node_group_arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "my_vpc_id" {
  value = module.vpc.vpc_id
}

output "my_public_subnets" {
  value = module.vpc.public_subnet_ids
}
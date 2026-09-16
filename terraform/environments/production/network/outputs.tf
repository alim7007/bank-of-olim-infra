output "vpc_id" {
  description = "Production VPC ID"
  value       = module.network.id
}

output "vpc_name" {
  description = "Production VPC name"
  value       = module.network.name
}

output "vpc_cidr" {
  description = "Production VPC CIDR"
  value       = module.network.ip_range
}
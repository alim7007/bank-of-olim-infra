output "id" {
  description = "ID of the VPC"
  value       = digitalocean_vpc.this.id
}

output "name" {
  description = "Name of the VPC"
  value       = digitalocean_vpc.this.name
}

output "ip_range" {
  description = "CIDR range of the VPC"
  value       = digitalocean_vpc.this.ip_range
}
# output "api_load_balancer_ip" {
#   description = "Public IP of the Kubernetes API load balancer"
#   value       = module.api_load_balancer.ip
# }

# output "kubernetes_api_endpoint" {
#   description = "Stable Kubernetes API endpoint"
#   value       = "${module.api_load_balancer.ip}:6443"
# }

output "control_plane_nodes" {
  value = local.control_plane_nodes
}

output "worker_nodes" {
  value = local.worker_nodes
}

output "all_nodes" {
  value = local.all_nodes
}

output "bastion_public_ip" {
  description = "Public IP of the SSH bastion"
  value       = module.bastion.public_ip
}

output "bastion_private_ip" {
  description = "Private VPC IP of the SSH bastion"
  value       = module.bastion.private_ip
}
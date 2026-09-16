locals {
  project_name = "bank-of-olim"
  environment  = "production"

  name_prefix = "${local.project_name}-${local.environment}"

  cluster_tag = "${local.name_prefix}-cluster"
  bastion_tag = "${local.name_prefix}-bastion"

  all_nodes = merge([
    for pool_name, pool in module.node_pool :
    pool.nodes
  ]...)

  control_plane_nodes = merge([
    for pool_name, pool in module.node_pool :
    pool.nodes
    if var.node_pools[pool_name].role == "control-plane"
  ]...)

  worker_nodes = merge([
    for pool_name, pool in module.node_pool :
    pool.nodes
    if var.node_pools[pool_name].role == "worker"
  ]...)

  #   node_public_cidrs = [
  #     for node in values(local.all_nodes) :
  #     "${node.public_ip}/32"
  #   ]
}
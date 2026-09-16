locals {
  pool_slug = replace(var.pool_name, "_", "-")

  nodes = {
    for i in range(var.node_count) :
    format("%02d", i + 1) => i
  }
}

resource "digitalocean_droplet" "this" {
  for_each = local.nodes

  name   = "${var.name_prefix}-${local.pool_slug}-${each.key}"
  region = var.region
  size   = var.size
  image  = var.image

  vpc_uuid = var.vpc_uuid
  ssh_keys = var.ssh_key_fingerprints
  tags     = var.tags

  monitoring        = true
  ipv6              = false
  public_networking = true
  graceful_shutdown = true

  backups = false
}
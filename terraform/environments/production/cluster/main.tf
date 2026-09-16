data "digitalocean_vpc" "production" {
  name = var.vpc_name
}

resource "digitalocean_ssh_key" "admin" {
  name = "${local.name_prefix}-admin"

  public_key = trimspace(
    file("${path.root}/../../../keys/production/admin.pub")
  )
}

resource "digitalocean_ssh_key" "automation" {
  name = "${local.name_prefix}-automation"

  public_key = trimspace(
    file("${path.root}/../../../keys/production/automation.pub")
  )
}

resource "digitalocean_tag" "cluster" {
  name = local.cluster_tag
}

resource "digitalocean_tag" "bastion" {
  name = local.bastion_tag
}

resource "digitalocean_tag" "role" {
  for_each = toset([
    "control-plane",
    "worker",
  ])

  name = "${local.name_prefix}-role-${each.value}"
}

resource "digitalocean_tag" "pool" {
  for_each = var.node_pools

  name = "${local.name_prefix}-pool-${replace(each.key, "_", "-")}"
}


module "bastion" {
  source = "../../../modules/bastion"

  name   = "${local.name_prefix}-bastion"
  region = var.region
  size   = var.bastion_size
  image  = var.bastion_image

  vpc_uuid = data.digitalocean_vpc.production.id

  ssh_key_fingerprint = digitalocean_ssh_key.admin.fingerprint

  admin_cidrs = var.admin_cidrs

  tags = [
    digitalocean_tag.bastion.name,
  ]
}

resource "digitalocean_firewall" "control_plane_api" {
  name = "${local.name_prefix}-control-plane-api"

  tags = [
    digitalocean_tag.role["control-plane"].name
  ]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "6443"
    source_addresses = var.admin_cidrs
  }
}

module "node_pool" {
  for_each = var.node_pools

  source = "../../../modules/node-pool"

  name_prefix = local.name_prefix
  pool_name   = each.key

  role       = each.value.role
  node_count = each.value.count
  size       = each.value.size

  image  = var.node_image
  region = var.region

  vpc_uuid = data.digitalocean_vpc.production.id

  ssh_key_fingerprints = [
    digitalocean_ssh_key.automation.fingerprint
  ]

  tags = [
    digitalocean_tag.cluster.name,
    digitalocean_tag.role[each.value.role].name,
    digitalocean_tag.pool[each.key].name,
  ]
}

# module "api_load_balancer" {
#   source = "../../../modules/load-balancer"

#   name     = "${local.name_prefix}-api"
#   region   = var.region
#   vpc_uuid = data.digitalocean_vpc.production.id

#   control_plane_tag = digitalocean_tag.role["control-plane"].name

#   allowed_cidrs = distinct(concat(
#     var.admin_cidrs,
#     local.node_public_cidrs
#   ))

# }

module "firewall" {
  source = "../../../modules/firewall"

  name        = "${local.name_prefix}-cluster"
  cluster_tag = digitalocean_tag.cluster.name
  bastion_tag = digitalocean_tag.bastion.name
  # admin_cidrs = var.admin_cidrs
}
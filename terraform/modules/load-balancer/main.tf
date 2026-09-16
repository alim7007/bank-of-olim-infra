resource "digitalocean_loadbalancer" "this" {
  name   = var.name
  region = var.region
  size   = "lb-small"

  vpc_uuid    = var.vpc_uuid
  droplet_tag = var.control_plane_tag

  type    = "REGIONAL"
  network = "EXTERNAL"

  forwarding_rule {
    entry_protocol  = "tcp"
    entry_port      = 6443
    target_protocol = "tcp"
    target_port     = 6443
  }

  healthcheck {
    protocol                 = "tcp"
    port                     = 6443
    check_interval_seconds   = 10
    response_timeout_seconds = 5
    unhealthy_threshold      = 3
    healthy_threshold        = 3
  }

  firewall {
    allow = [
      for cidr in var.allowed_cidrs :
      "cidr:${cidr}"
    ]
  }
}
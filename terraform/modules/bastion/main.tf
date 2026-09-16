resource "digitalocean_droplet" "this" {
  name   = var.name
  region = var.region
  size   = var.size
  image  = var.image

  vpc_uuid = var.vpc_uuid

  ssh_keys = [
    var.ssh_key_fingerprint
  ]

  tags = var.tags

  monitoring        = true
  ipv6              = false
  public_networking = true
  graceful_shutdown = true
  backups           = false
}

resource "digitalocean_firewall" "this" {
  name        = "${var.name}-firewall"
  droplet_ids = [digitalocean_droplet.this.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.admin_cidrs
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0"]
  }
}
resource "digitalocean_firewall" "worker_ingress" {
  name = "${local.name_prefix}-worker-ingress"

  tags = [
    digitalocean_tag.role["worker"].name
  ]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}
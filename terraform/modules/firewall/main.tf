resource "digitalocean_firewall" "this" {
  name = var.name
  tags = [var.cluster_tag]

  # SSH to nodes only through bastion.
  inbound_rule {
    protocol    = "tcp"
    port_range  = "22"
    source_tags = [var.bastion_tag]
  }

  # Kubernetes API from trusted admin IPs.
  # inbound_rule {
  #   protocol         = "tcp"
  #   port_range       = "6443"
  #   source_addresses = var.admin_cidrs
  # }

  # Internal node-to-node TCP traffic.
  inbound_rule {
    protocol    = "tcp"
    port_range  = "1-21"
    source_tags = [var.cluster_tag]
  }

  inbound_rule {
    protocol    = "tcp"
    port_range  = "23-65535"
    source_tags = [var.cluster_tag]
  }

  # Internal node-to-node UDP traffic.
  inbound_rule {
    protocol    = "udp"
    port_range  = "1-65535"
    source_tags = [var.cluster_tag]
  }

  inbound_rule {
    protocol    = "icmp"
    source_tags = [var.cluster_tag]
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
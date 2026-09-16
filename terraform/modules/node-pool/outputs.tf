output "nodes" {
  value = {
    for key, node in digitalocean_droplet.this :
    node.name => {
      id         = node.id
      public_ip  = node.ipv4_address
      private_ip = node.ipv4_address_private
      role       = var.role
      pool       = var.pool_name
    }
  }
}
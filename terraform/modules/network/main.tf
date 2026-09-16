resource "digitalocean_vpc" "this" {
  name        = var.name
  region      = var.region
  ip_range    = var.ip_range
  description = "Private network for ${var.name}"
}
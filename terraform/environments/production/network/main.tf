module "network" {
  source = "../../../modules/network"

  name     = "${local.name_prefix}-vpc"
  region   = var.region
  ip_range = var.vpc_cidr
}
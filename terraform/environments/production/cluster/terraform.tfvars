region = "fra1"

vpc_name = "bank-of-olim-production-vpc"

admin_cidrs = [
  "144.124.192.110/32"
]

node_pools = {
  control_plane = {
    role  = "control-plane"
    count = 1
    size  = "s-2vcpu-4gb"
  }

  general = {
    role  = "worker"
    count = 2
    size  = "s-2vcpu-4gb"
  }
}
terraform {
  cloud {
    organization = "olim-infrastructure"

    workspaces {
      name = "bank-of-olim-production-cluster"
    }
  }
}
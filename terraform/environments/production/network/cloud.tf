terraform {
  cloud {
    # or organization comes from TF_CLOUD_ORGANIZATION
    organization = "olim-infrastructure"

    workspaces {
      name = "bank-of-olim-production-network"
    }
  }
}
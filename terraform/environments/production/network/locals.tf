locals {
  project_name = "bank-of-olim"
  environment  = "production"

  name_prefix = "${local.project_name}-${local.environment}"
}
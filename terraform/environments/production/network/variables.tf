variable "region" {
  description = "DigitalOcean region for production infrastructure"
  type        = string
}

variable "vpc_cidr" {
  description = "Private CIDR range for the production VPC"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid CIDR, for example 10.10.0.0/16."
  }
}
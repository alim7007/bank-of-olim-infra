variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "region" {
  description = "DigitalOcean region for the VPC"
  type        = string
}

variable "ip_range" {
  description = "Private CIDR range of the VPC"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.ip_range))
    error_message = "ip_range must be a valid CIDR."
  }
}
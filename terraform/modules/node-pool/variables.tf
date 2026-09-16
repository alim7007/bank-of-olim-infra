variable "name_prefix" {
  type = string
}

variable "pool_name" {
  type = string
}

variable "role" {
  type = string

  validation {
    condition     = contains(["control-plane", "worker"], var.role)
    error_message = "role must be either control-plane or worker."
  }
}

variable "node_count" {
  type = number

  validation {
    condition     = var.node_count >= 0 && floor(var.node_count) == var.node_count
    error_message = "node_count must be a non-negative whole number."
  }
}

variable "size" {
  type = string
}

variable "image" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_uuid" {
  type = string
}

variable "ssh_key_fingerprints" {
  type = list(string)
}

variable "tags" {
  type = list(string)
}
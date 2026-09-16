variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "size" {
  type = string
}

variable "image" {
  type = string
}

variable "vpc_uuid" {
  type = string
}

variable "ssh_key_fingerprint" {
  type = string
}

variable "admin_cidrs" {
  type = list(string)
}

variable "tags" {
  type = list(string)
}
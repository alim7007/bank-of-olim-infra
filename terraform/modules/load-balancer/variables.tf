variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_uuid" {
  type = string
}

variable "control_plane_tag" {
  type = string
}

variable "allowed_cidrs" {
  type = list(string)
}
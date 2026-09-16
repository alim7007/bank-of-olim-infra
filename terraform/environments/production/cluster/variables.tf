variable "region" {
  description = "DigitalOcean region"
  type        = string
}

variable "vpc_name" {
  description = "Existing production VPC name"
  type        = string
}

variable "admin_cidrs" {
  description = "Trusted CIDRs allowed to access SSH and Kubernetes API"
  type        = list(string)
}

variable "node_image" {
  description = "Operating system image for Kubernetes nodes"
  type        = string
  default     = "ubuntu-24-04-x64"
}

variable "bastion_size" {
  description = "Droplet size for the SSH bastion"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "bastion_image" {
  description = "Operating system image for the SSH bastion"
  type        = string
  default     = "ubuntu-24-04-x64"
}

variable "node_pools" {
  description = "Kubernetes node pools"

  type = map(object({
    role  = string
    count = number
    size  = string
  }))

  validation {
    condition = alltrue([
      for pool in values(var.node_pools) :
      contains(["control-plane", "worker"], pool.role)
    ])

    error_message = "Every node pool role must be control-plane or worker."
  }

  validation {
    condition = length([
      for pool in values(var.node_pools) :
      pool if pool.role == "control-plane"
    ]) == 1

    error_message = "Exactly one control-plane node pool must be defined."
  }

  validation {
    condition = contains(
      [1, 3, 5, 7],
      sum([
        for pool in values(var.node_pools) :
        pool.role == "control-plane" ? pool.count : 0
      ])
    )

    error_message = "Control-plane count must be 1, 3, 5, or 7."
  }
}
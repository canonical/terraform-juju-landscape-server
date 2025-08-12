# © 2025 Canonical Ltd.
# See LICENSE file for licensing details.

# Model level variables

variable "model" {
  description = "The name of the Juju model to deploy Landscape Server to"
  type        = null
}

variable "path_to_ssh_key" {
  description = "The path to the SSH key to use for the model"
  type        = string
}

variable "cloud_name" {
  description = "Name of the Juju cloud where the model will operate"
  default     = "localhost"
}

variable "cloud_region" {
  description = "Region of the Juju cloud where the model will operate"
  default     = "localhost"
}

variable "credential_name" {
  description = "The name of the Juju credential to use for the model"
  type        = string
  default     = "localhost"
}

variable "arch" {
  type        = string
  default     = "amd64"
  description = "CPU architecture"
}

# Modules

variable "landscape_server" {
  type = object({
    app_name    = optional(string, "landscape-server")
    channel     = optional(string, "latest-stable/edge")
    config      = optional(map(string), {})
    constraints = optional(string, "arch=${var.arch}")
    resources   = optional(map(string), {})
    revision    = optional(number, 144)
    base        = optional(string, "ubuntu@22.04")
    units       = optional(number, 1)
  })
}

 variable "postgresql" {
  type = object({
    app_name    = optional(string, "postgresql")
    channel     = optional(string, "14/stable")
    config      = optional(map(string), {})
    constraints = optional(string, "arch=${var.arch}")
    resources   = optional(map(string), {})
    revision    = optional(number)
    base        = optional(string, "ubuntu@22.04")
    units       = optional(number, 1)
  })
}

 variable "haproxy" {
  type = object({
    app_name    = optional(string, "haproxy")
    channel     = optional(string, "latest/edge")
    config      = optional(map(string), {})
    constraints = optional(string, "arch=${var.arch}")
    resources   = optional(map(string), {})
    revision    = optional(number)
    base        = optional(string, "ubuntu@22.04")
    units       = optional(number, 1)
  })
}

 variable "rabbitmq_server" {
  type = object({
    app_name    = optional(string, "rabbitmq-server")
    channel     = optional(string, "latest/edge")
    config      = optional(map(string), {})
    constraints = optional(string, "arch=${var.arch}")
    resources   = optional(map(string), {})
    revision    = optional(number)
    base        = optional(string, "ubuntu@24.04")
    units       = optional(number, 1)
  })
}

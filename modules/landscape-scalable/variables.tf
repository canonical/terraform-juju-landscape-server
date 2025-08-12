# © 2025 Canonical Ltd.
# See LICENSE file for licensing details.

# Model level variables

variable "create_model" {
  description = "Allows to skip Juju model creation and re-use a model created in a higher level module"
  type        = bool
  default     = true
}

variable "model" {
  description = "The name of the Juju model to deploy Landscape Server to"
  type        = string
}

variable "domain" {
  type    = string
  default = "example.com"
}

variable "hostname" {
  type    = string
  default = "landscape"
}

# Modules

variable "landscape_server" {
  type = object({
    app_name    = optional(string, "landscape-server")
    channel     = optional(string, "latest-stable/edge")
    config      = optional(map(string), {})
    constraints = optional(string, "arch=amd64")
    resources   = optional(map(string), {})
    revision    = optional(number)
    base        = optional(string, "ubuntu@22.04")
    units       = optional(number, 1)
  })
}

variable "postgresql" {
  type = object({
    app_name    = optional(string, "postgresql")
    channel     = optional(string, "14/stable")
    config      = optional(map(string), {})
    constraints = optional(string, "arch=amd64")
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
    constraints = optional(string, "arch=amd64")
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
    constraints = optional(string, "arch=amd64")
    resources   = optional(map(string), {})
    revision    = optional(number)
    base        = optional(string, "ubuntu@24.04")
    units       = optional(number, 1)
  })
}

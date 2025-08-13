# © 2025 Canonical Ltd.
# See LICENSE file for licensing details.

# Model level variables

variable "create_model" {
  description = "Allows to skip Juju model creation and re-use a model created in a higher level module"
  type        = bool
  default     = true
}

variable "wait" {
  description = "Wait for the model to settle as part of the provisioning. Needed if setting up SMTP."
  type        = bool
  default     = true
}

check "wait_required_for_smtp" {
  assert {
    condition     = !local.using_smtp || var.wait
    error_message = "`wait` must be `true` if using SMTP."
  }
}

variable "model" {
  description = "The name of the Juju model to deploy Landscape Server to"
  type        = string
}

variable "path_to_ssh_key" {
  description = "The path to the SSH key to use for the model"
  type        = string
}

variable "cloud_name" {
  description = "Name of the Juju cloud where the model will operate"
  default     = "localhost"
  type        = string
}

variable "cloud_region" {
  description = "Region of the Juju cloud where the model will operate"
  default     = "localhost"
  type        = string
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

variable "domain" {
  type    = string
  default = "example.com"
}

variable "hostname" {
  type    = string
  default = "landscape"
}

variable "smtp_host" {
  type    = string
  default = "smtp.sendgrid.net"
}

variable "smtp_port" {
  type    = number
  default = 587
}

variable "smtp_username" {
  type    = string
  default = "apikey"
}

variable "smtp_password" {
  type      = string
  sensitive = true
  default   = null
}

# Charm modules

variable "landscape_server" {
  type = object({
    app_name = optional(string, "landscape-server")
    channel  = optional(string, "latest-stable/edge")
    config = optional(map(string), {
      autoregistration = true
      landscape_ppa    = "ppa:landscape/self-hosted-beta"
    })
    constraints = optional(string, "arch=amd64")
    resources   = optional(map(string), {})
    revision    = optional(number)
    base        = optional(string, "ubuntu@22.04")
    units       = optional(number, 1)
  })
}

variable "postgresql" {
  type = object({
    app_name = optional(string, "postgresql")
    channel  = optional(string, "14/stable")
    config = optional(map(string), {
      plugin_plpython3u_enable     = true
      plugin_ltree_enable          = true
      plugin_intarray_enable       = true
      plugin_debversion_enable     = true
      plugin_pg_trgm_enable        = true
      experimental_max_connections = 500
    })
    constraints = optional(string, "arch=amd64")
    resources   = optional(map(string), {})
    revision    = optional(number)
    base        = optional(string, "ubuntu@22.04")
    units       = optional(number, 1)
  })
}

variable "haproxy" {
  type = object({
    app_name = optional(string, "haproxy")
    channel  = optional(string, "latest/edge")
    config = optional(map(string), {
      default_timeouts            = "queue 60000, connect 5000, client 120000, server 120000"
      global_default_bind_options = "no-tlsv10"
      services                    = ""
      ssl_cert                    = "SELFSIGNED"
    })
    constraints = optional(string, "arch=amd64")
    resources   = optional(map(string), {})
    revision    = optional(number)
    base        = optional(string, "ubuntu@22.04")
    units       = optional(number, 1)
  })
}

variable "rabbitmq_server" {
  type = object({
    app_name = optional(string, "rabbitmq-server")
    channel  = optional(string, "latest/edge")
    config = optional(map(string), {
      consumer-timeout = 259200000
    })
    constraints = optional(string, "arch=amd64")
    resources   = optional(map(string), {})
    revision    = optional(number)
    base        = optional(string, "ubuntu@24.04")
    units       = optional(number, 1)
  })
}

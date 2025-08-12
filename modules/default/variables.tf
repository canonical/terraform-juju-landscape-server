# Juju model

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

# Landscape Server

variable "min_install" {
  description = "Install recommended packages like landscape-hashids but takes longer to install"
  type        = bool
  default     = true
}

variable "admin_name" {
  description = "First and last name of the default admin"
  type        = string
  default     = "Landscape Admin"
}

variable "admin_email" {
  description = "Email of the default admin"
  type        = string
  default     = ""
}

variable "admin_password" {
  description = "Password of the default admin"
  type        = string
  sensitive   = true
  default     = ""
}

variable "landscape_ppa" {
  description = "PPA to use for the Landscape Server charm"
  type        = string
  default     = "ppa:landscape/self-hosted-beta"
}

variable "landscape_server_channel" {
  type    = string
  default = "latest-stable/edge"
}


variable "landscape_server_base" {
  type    = string
  default = "ubuntu@22.04"
}

variable "landscape_server_units" {
  description = "Landscape Server charm units number"
  type        = number
  default     = 1
}

variable "domain" {
  type    = string
  default = "landscape"
}

variable "hostname" {
  type    = string
  default = "example.com"
}

variable "registration_key" {
  type    = string
  default = ""
}

variable "landscape_server_revision" {
  type    = number
  default = 144
}

variable "smtp_host" {
  type    = string
  default = ""
}

variable "smtp_port" {
  type    = number
  default = 587
}

variable "smtp_username" {
  type    = string
  default = ""
}

variable "smtp_password" {
  type      = string
  sensitive = true
  default   = ""
}

variable "system_email" {
  type    = string
  default = ""
}

# HAProxy

variable "haproxy_units" {
  type    = number
  default = 1
}

variable "haproxy_revision" {
  type    = number
  default = 147
}

variable "haproxy_channel" {
  type    = string
  default = "latest/edge"
}

variable "haproxy_base" {
  type    = string
  default = "ubuntu@22.04"
}

variable "b64_ssl_cert" {
  type        = string
  default     = ""
  description = "Base64-encoded SSL cert contents"
}

variable "b64_ssl_key" {
  type        = string
  description = "Base64-encoded SSL key contents"
  sensitive   = true
  default     = ""
}

# PostgreSQL

variable "postgresql_units" {
  type    = number
  default = 1
}

variable "postgresql_revision" {
  type    = number
  default = 553
}

variable "postgresql_channel" {
  type    = string
  default = "14/stable"
}

variable "postgresql_base" {
  type    = string
  default = "ubuntu@22.04"
}

# RabbitMQ Server

variable "rabbitmq_server_units" {
  type    = number
  default = 1
}

variable "rabbitmq_server_revision" {
  type    = number
  default = 237
}

variable "rabbitmq_server_channel" {
  type    = string
  default = "latest/edge"
}

variable "rabbitmq_server_base" {
  type    = string
  default = "ubuntu@24.04"
}

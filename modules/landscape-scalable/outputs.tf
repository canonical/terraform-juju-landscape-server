# © 2025 Canonical Ltd.
# See LICENSE file for licensing details.

output "registration_key" {
  value = lookup(var.landscape_server.config, "registration_key", null)
}

output "admin_email" {
  value = lookup(var.landscape_server.config, "admin_email", null)
}

output "admin_password" {
  value     = lookup(var.landscape_server.config, "admin_password", null)
  sensitive = true
}

output "applications" {
  value = {
    landscape_server = module.landscape_server
    haproxy          = module.haproxy
    postgresql       = module.postgresql
    rabbitmq_server  = juju_application.rabbitmq_server
  }
}

output "self_signed_server" {
  value = local.self_signed ? true : false
}

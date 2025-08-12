# © 2025 Canonical Ltd.
# See LICENSE file for licensing details.
output "model_name" {
  description = "Name of the Juju model"
  value       = data.juju_model.landscape.name
}

output "landscape_account_name" {
  value = "standalone"
}

output "registration_key" {
  value     = lookup(var.landscape_server.config, "registration_key", null)
  sensitive = true
}

output "landscape_root_url" {
  value = local.root_url
}

output "self_signed_server" {
  value     = local.self_signed ? true : false
  sensitive = true
}

output "admin_email" {
  value = lookup(var.landscape_server.config, "admin_email", null)
}

output "admin_password" {
  value     = lookup(var.landscape_server.config, "admin_password", null)
  sensitive = true
}

output "using_smtp" {
  value     = local.using_smtp ? true : false
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

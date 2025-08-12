# © 2025 Canonical Ltd.
# See LICENSE file for licensing details.
locals {
  self_signed  = var.haproxy.config.b64_ssl_key == "" || var.haproxy.config.b64_ssl_cert == ""
  using_smtp   = !local.self_signed && var.landscape_server.config.smtp_password != "" && var.landscape_server.config.smtp_host != "" && var.landscape_server.config.smtp_username != ""
  legacy_amqp  = var.landscape_server.channel != "latest-stable/edge" || var.landscape_server.revision <= 141
}

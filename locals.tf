locals {
  self_signed  = var.b64_ssl_key == "" || var.b64_ssl_cert == ""
  root_url     = "${var.hostname}.${var.domain}"
  using_smtp   = !local.self_signed && var.smtp_password != "" && var.smtp_host != "" && var.smtp_username != ""
  system_email = var.system_email != "" ? var.system_email : "${split("@", var.admin_email)[0]}@${var.domain}" 
  legacy_amqp  = var.landscape_server_channel != "latest-stable/edge" && var.landscape_server_revision < 143
}

locals {
  self_signed = local.b64_ssl_key == "" || local.b64_ssl_cert == ""
  root_url = "${var.hostname}.${var.domain}"
  using_smtp = var.smtp_password != "" && var.smtp_host != "" && var.smtp_username != ""
  system_email = "${split("@", var.admin_email)[0]}@${var.domain}"
  b64_ssl_cert = base64encode(var.ssl_cert_content)
  b64_ssl_key  = base64encode(var.ssl_key_content)
}

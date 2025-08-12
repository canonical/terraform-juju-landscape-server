# © 2025 Canonical Ltd.
# See LICENSE file for licensing details.

module "landscape_server" {
  source      = "git::https://github.com/jansdhillon/landscape-charm.git//terraform?ref=tf-charm-module-latest-stable-edge"
  model       = var.create_model ? juju_model.landscape[0].name : local.model
  config      = var.landscape_server.config
  app_name    = var.landscape_server.app_name
  channel     = var.landscape_server.channel
  constraints = var.landscape_server.constraints
  revision    = var.landscape_server.revision
  base        = var.landscape_server.base
}

# Setup Postfix (if configured)
resource "terraform_data" "setup_postfix" {
  depends_on = [terraform_data.juju_wait_for_landscape]

  triggers_replace = {
    smtp_host     = lookup(var.landscape_server.config, "smtp_host", "smtp.sendgrid.net")
    smtp_port     = lookup(var.landscape_server.config, "smtp_port", 587)
    smtp_username = lookup(var.landscape_server.config, "smtp_username", "")
    smtp_password = lookup(var.landscape_server.config, "smtp_password", "")
    fqdn          = local.root_url
    domain        = var.domain
  }

  provisioner "local-exec" {
    command = <<-EOT
      SMTP_HOST='${self.triggers_replace.smtp_host}'
      SMTP_PORT='${self.triggers_replace.smtp_port}'
      SMTP_USERNAME='${self.triggers_replace.smtp_username}'
      SMTP_PASSWORD='${self.triggers_replace.smtp_password}'
      FQDN='${self.triggers_replace.fqdn}'
      DOMAIN='${self.triggers_replace.domain}'
      MODEL='${var.model}'

      juju scp -m "$MODEL" "${path.module}/setup_postfix.sh" landscape-server/leader:/tmp/setup_postfix.sh
      juju exec -m "$MODEL" --application landscape-server -- \
        "sudo chmod +x /tmp/setup_postfix.sh && /tmp/setup_postfix.sh \"$SMTP_HOST\" \"$SMTP_PORT\" \"$SMTP_USERNAME\" \"$SMTP_PASSWORD\" \"$FQDN\" \"$DOMAIN\""
    EOT
  }

  lifecycle {
    ignore_changes = all
  }

  count = local.using_smtp ? 1 : 0
}

module "haproxy" {
  source      = "git::https://github.com/canonical/haproxy-operator.git//terraform/charm?ref=rev211"
  model       = var.create_model ? juju_model.landscape[0].name : local.model
  config      = var.haproxy.config
  app_name    = var.haproxy.app_name
  channel     = var.haproxy.channel
  constraints = var.haproxy.constraints
  revision    = var.haproxy.revision
  base        = var.haproxy.base
}

module "postgresql" {
  source = "git::https://github.com/canonical/postgresql-operator.git//terraform?ref=rev848"
  # NOTE: they should comply here, may need to update later if they conform to the inputs
  juju_model_name = var.create_model ? juju_model.landscape[0].name : local.model
  config          = var.postgresql.config
  app_name        = var.postgresql.app_name
  channel         = var.postgresql.channel
  constraints     = var.postgresql.constraints
  revision        = var.postgresql.revision
  base            = var.postgresql.base
}

# TODO: Replace with internal charm module if/when it's created
resource "juju_application" "rabbitmq_server" {
  name        = "rabbitmq-server"
  model       = var.create_model ? juju_model.landscape[0].name : local.model
  units       = var.rabbitmq_server.units
  constraints = var.rabbitmq_server.constraints
  config      = var.rabbitmq_server.config

  charm {
    name     = "rabbitmq-server"
    revision = var.rabbitmq_server.revision
    channel  = var.rabbitmq_server.channel
    base     = var.rabbitmq_server.base
  }
}

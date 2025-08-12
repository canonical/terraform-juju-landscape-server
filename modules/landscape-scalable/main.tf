# © 2025 Canonical Ltd.
# See LICENSE file for licensing details.
data "juju_model" "landscape" {
  name = var.model
}

# Wait for Landscape Server model to stabilize
resource "terraform_data" "juju_wait_for_landscape_server" {
  depends_on = [data.juju_model.landscape]
  provisioner "local-exec" {
    command = <<-EOT
      juju wait-for model $MODEL --timeout 3600s --query='forEach(units, unit => (unit.workload-status == "active" || unit.workload-status == "blocked"))'
    EOT
    environment = {
      MODEL = data.juju_model.landscape.name
    }
  }

  count = local.using_smtp ? 1 : 0
}

# Setup Postfix (if configured)
resource "terraform_data" "setup_postfix" {
  depends_on = [terraform_data.juju_wait_for_landscape_server]

  triggers_replace = {
    smtp_host     = var.landscape_server.config["smtp_host"]
    smtp_port     = var.landscape_server.config["smtp_port"]
    smtp_username = var.landscape_server.config["smtp_username"]
    smtp_password = var.landscape_server.config["smtp_password"]
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
    # only run once
    ignore_changes = all
  }

  count = local.using_smtp ? 1 : 0
}

module "landscape_server" {
  source      = "git::https://github.com/jansdhillon/landscape-charm.git//terraform?ref=tf-charm-module-latest-stable-edge"
  model       = var.model
  config      = var.landscape_server.config
  app_name    = var.landscape_server.app_name
  channel     = var.landscape_server.channel
  constraints = var.landscape_server.constraints
  revision    = var.landscape_server.revision
  base        = var.landscape_server.base
}

module "haproxy" {
  source      = "git::https://github.com/canonical/haproxy-operator.git//terraform/charm"
  model       = var.model
  config      = var.haproxy.config
  app_name    = var.haproxy.app_name
  channel     = var.haproxy.channel
  constraints = var.haproxy.constraints
  revision    = var.haproxy.revision
  base        = var.haproxy.base
}

module "postgresql" {
  source = "git::https://github.com/canonical/postgresql-operator.git//terraform"
  # NOTE: they should comply here, may need to update later if they conform to the inputs
  juju_model_name = var.model
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
  model       = var.model
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

resource "juju_integration" "landscape_server_inbound_amqp" {
  model = var.model

  application {
    name     = module.landscape_server.app_name
    endpoint = module.landscape_server.requires.inbound_amqp
  }

  application {
    name = juju_application.rabbitmq_server.name
  }

  depends_on = [module.landscape_server, juju_application.rabbitmq_server]

  // Only run if Landscape Server is using the new AMQP relations
  // https://github.com/canonical/landscape-charm/blob/main/bundle-examples/bundle.yaml
  count = local.legacy_amqp ? 0 : 1
}

resource "juju_integration" "landscape_server_outbound_amqp" {
  model = var.model

  application {
    name     = module.landscape_server.app_name
    endpoint = module.landscape_server.requires.outbound_amqp
  }

  application {
    name = juju_application.rabbitmq_server.name
  }

  depends_on = [module.landscape_server, juju_application.rabbitmq_server]

  count = local.legacy_amqp ? 0 : 1
}

# TODO: update when RMQ charm module exists
resource "juju_integration" "landscape_server_rabbitmq_server" {
  model = var.model

  application {
    name = module.landscape_server.app_name
  }

  application {
    name = juju_application.rabbitmq_server.name
  }

  depends_on = [module.landscape_server, juju_application.rabbitmq_server]

  // Only run if Landscape Server is using the legacy AMQP relations
  // https://github.com/canonical/landscape-charm/blob/24.04/bundle-examples/bundle.yaml
  count = local.legacy_amqp ? 1 : 0
}

resource "juju_integration" "landscape_server_haproxy" {
  model = var.model

  application {
    name = module.landscape_server.app_name
  }

  application {
    name = module.haproxy.app_name
  }

}


resource "juju_integration" "landscape_server_postgresql" {
  model = var.model

  application {
    name     = module.landscape_server.app_name
    endpoint = module.landscape_server.requires.db
  }

  application {
    # Output should be `app_name`, may have to change later when they comply
    name     = module.postgresql.application_name
    endpoint = "db-admin"
  }

}

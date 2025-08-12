# © 2025 Canonical Ltd.
# See LICENSE file for licensing details.

resource "juju_integration" "landscape_server_inbound_amqp" {
  model = var.create_model ? juju_model.landscape[0].name : local.model

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
  model = var.create_model ? juju_model.landscape[0].name : local.model

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
  model = var.create_model ? juju_model.landscape[0].name : local.model

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
  model = var.create_model ? juju_model.landscape[0].name : local.model

  application {
    name = module.landscape_server.app_name
  }

  application {
    name = module.haproxy.app_name
  }

}


resource "juju_integration" "landscape_server_postgresql" {
  model = var.create_model ? juju_model.landscape[0].name : local.model

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

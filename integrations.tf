resource "juju_integration" "landscape_server_inbound_amqp" {
  model = var.model_name

  application {
    name     = juju_application.landscape_server.name
    endpoint = "inbound-amqp"
  }

  application {
    name = juju_application.rabbitmq_server.name
  }

  // Ideally this would just be handled by the charms but this
  // seems to be needed: 
  // https://registry.terraform.io/providers/juju/juju/latest/docs/resources/integration#example-usage
  lifecycle {
    replace_triggered_by = [
      juju_application.landscape_server.name,
      juju_application.landscape_server.model,
      juju_application.landscape_server.constraints,
      juju_application.landscape_server.placement,
      juju_application.landscape_server.charm.name,

      juju_application.rabbitmq_server.name,
      juju_application.rabbitmq_server.model,
      juju_application.rabbitmq_server.constraints,
      juju_application.rabbitmq_server.charm.name,
      juju_application.rabbitmq_server.placement,
    ]
  }

  depends_on = [juju_application.landscape_server, juju_application.rabbitmq_server]

  // Only run if Landscape Server is using the new AMQP relations
  // https://github.com/canonical/landscape-charm/blob/main/bundle-examples/bundle.yaml
  count = local.legacy_amqp ? 0 : 1
}

resource "juju_integration" "landscape_server_outbound_amqp" {
  model = var.model_name

  application {
    name     = juju_application.landscape_server.name
    endpoint = "outbound-amqp"
  }

  application {
    name = juju_application.rabbitmq_server.name
  }

  lifecycle {
    replace_triggered_by = [
      juju_application.landscape_server.name,
      juju_application.landscape_server.model,
      juju_application.landscape_server.constraints,
      juju_application.landscape_server.placement,
      juju_application.landscape_server.charm.name,

      juju_application.rabbitmq_server.name,
      juju_application.rabbitmq_server.model,
      juju_application.rabbitmq_server.constraints,
      juju_application.rabbitmq_server.charm.name,
      juju_application.rabbitmq_server.placement,
    ]
  }

  depends_on = [juju_application.landscape_server, juju_application.rabbitmq_server]

  count = local.legacy_amqp ? 0 : 1
}

resource "juju_integration" "landscape_server_rabbitmq_server" {
  model = var.model_name

  application {
    name = juju_application.landscape_server.name
  }

  application {
    name = juju_application.rabbitmq_server.name
  }

  lifecycle {
    replace_triggered_by = [
      juju_application.landscape_server.name,
      juju_application.landscape_server.model,
      juju_application.landscape_server.constraints,
      juju_application.landscape_server.placement,
      juju_application.landscape_server.charm.name,

      juju_application.rabbitmq_server.name,
      juju_application.rabbitmq_server.model,
      juju_application.rabbitmq_server.constraints,
      juju_application.rabbitmq_server.charm.name,
      juju_application.rabbitmq_server.placement,
    ]
  }

  depends_on = [juju_application.landscape_server, juju_application.rabbitmq_server]

  // Only run if Landscape Server is using the legacy AMQP relations
  // https://github.com/canonical/landscape-charm/blob/24.04/bundle-examples/bundle.yaml
  count = local.legacy_amqp ? 1 : 0
}

resource "juju_integration" "landscape_server_haproxy" {
  model = var.model_name

  application {
    name = juju_application.landscape_server.name
  }

  application {
    name = juju_application.haproxy.name
  }

  lifecycle {
    replace_triggered_by = [
      juju_application.landscape_server.name,
      juju_application.landscape_server.model,
      juju_application.landscape_server.constraints,
      juju_application.landscape_server.charm.name,
      juju_application.landscape_server.placement,

      juju_application.haproxy.name,
      juju_application.haproxy.model,
      juju_application.haproxy.constraints,
      juju_application.haproxy.charm.name,
      juju_application.haproxy.placement
    ]
  }

  depends_on = [juju_application.landscape_server, juju_application.haproxy]
}


resource "juju_integration" "landscape_server_postgresql" {
  model = var.model_name

  application {
    name     = juju_application.landscape_server.name
    endpoint = "db"
  }

  application {
    name     = juju_application.postgresql.name
    endpoint = "db-admin"
  }

  lifecycle {
    replace_triggered_by = [
      juju_application.landscape_server.name,
      juju_application.landscape_server.model,
      juju_application.landscape_server.constraints,
      juju_application.landscape_server.charm.name,
      juju_application.landscape_server.placement,

      juju_application.postgresql.name,
      juju_application.postgresql.model,
      juju_application.postgresql.constraints,
      juju_application.postgresql.charm.name,
      juju_application.postgresql.placement,
    ]
  }

  depends_on = [juju_application.landscape_server, juju_application.postgresql]
}

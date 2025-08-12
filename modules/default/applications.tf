# © 2025 Canonical Ltd.
# See LICENSE file for licensing details.
module "landscape_server" {
  source = "git::https://github.com/jansdhillon/landscape-charm.git//terraform?ref=tf-charm-module-latest-stable-edge"
  model  = var.model
  config = var.landscape_server.config
}

module "haproxy" {
  source = "git::https://github.com/canonical/haproxy-operator.git//terraform/charm"
  model  = var.model
  config = var.haproxy.config
}

resource "juju_application" "postgresql" {
  name        = "postgresql"
  model       = var.model
  units       = var.postgresql_units
  constraints = "arch=${var.arch} mem=2048M"


  charm {
    name     = "postgresql"
    revision = var.postgresql_revision
    channel  = var.postgresql_channel
    base     = var.postgresql_base
  }

  config = {
    plugin_plpython3u_enable     = true
    plugin_ltree_enable          = true
    plugin_intarray_enable       = true
    plugin_debversion_enable     = true
    plugin_pg_trgm_enable        = true
    experimental_max_connections = 500
  }

  depends_on = [juju_model.landscape]


}

resource "juju_application" "rabbitmq_server" {
  name        = "rabbitmq-server"
  model       = var.model
  units       = var.rabbitmq_server_units
  constraints = "arch=${var.arch} mem=2048M"


  charm {
    name     = "rabbitmq-server"
    revision = var.rabbitmq_server_revision
    channel  = var.rabbitmq_server_channel
    base     = var.rabbitmq_server_base
  }

  config = {
    consumer-timeout = 259200000
  }

  depends_on = [juju_model.landscape]

}

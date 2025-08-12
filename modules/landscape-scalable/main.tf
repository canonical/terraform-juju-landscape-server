# © 2025 Canonical Ltd.
# See LICENSE file for licensing details.
resource "juju_model" "landscape" {
  count       = var.create_model ? 1 : 0
  name        = local.model
  constraints = "arch=${var.arch}"
  credential  = var.credential_name

  cloud {
    name   = var.cloud_name
    region = var.cloud_region
  }
}

resource "juju_ssh_key" "model_ssh_key" {
  model      = var.model
  payload    = trimspace(file(var.path_to_ssh_key))
  depends_on = [juju_model.landscape]
}


# Wait for Landscape Server model to stabilize
resource "terraform_data" "juju_wait_for_landscape" {
  depends_on = [juju_model.landscape[0]]
  provisioner "local-exec" {
    command = <<-EOT
      juju wait-for model $MODEL --timeout 3600s --query='forEach(units, unit => (unit.workload-status == "active" || unit.workload-status == "blocked"))'
    EOT
    environment = {
      MODEL = var.create_model ? juju_model.landscape[0].name : local.model
    }
  }

  count = local.using_smtp ? 1 : 0
}

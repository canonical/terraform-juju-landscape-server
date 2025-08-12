# © 2025 Canonical Ltd.
# See LICENSE file for licensing details.
resource "juju_model" "landscape" {
  count = var.create_model ? 1 : 0
  name  = local.model
}

locals {
  model = "landscape"
}

# Wait for Landscape Server model to stabilize
resource "terraform_data" "juju_wait_for_landscape" {
  depends_on = [juju_model.landscape[0]]
  provisioner "local-exec" {
    command = <<-EOT
      juju wait-for model $MODEL --timeout 3600s --query='forEach(units, unit => (unit.workload-status == "active" || unit.workload-status == "blocked"))'
    EOT
    environment = {
      MODEL = juju_model.landscape[0].name
    }
  }

  count = local.using_smtp ? 1 : 0
}

# terraform-landscape-server

This is a Terraform module facilitating the deployment of Landscape Server, using the [Terraform juju provider](https://github.com/juju/terraform-provider-juju/). For more information, refer to the provider [documentation](https://registry.terraform.io/providers/juju/juju/latest/docs).

## Configure a Juju cloud

This module requires that a Juju cloud is already initialized with a credential for it defined and accessible.
For example, to use `localhost`:

```sh
juju bootstrap localhost landscape-controller
```

## Initialize the module

```sh
terraform init
```

> [!TIP]
> The module can be customized by editing the values in `terraform.tfvars.example`.

## Deploy Landscape Server

Remove the `.example` extension from `terraform.tfvars.example` to use those variables.

Then, apply the plan:

```sh
terraform apply
```

## API

### Inputs

The solution module offers the following configurable inputs:

| Name | Type | Description | Required |
| - | - | - | - |
| `create_model` | bool | Allows to skip Juju model creation and re-use a model created in a higher level module | False |
| `model` | string | The name of the Juju model to deploy Landscape Server to | True |
| `domain` | string | Domain name for Landscape Server | False |
| `hostname` | string | Hostname for Landscape Server | False |
| `landscape_server` | object | Configuration for the landscape-server charm including app_name, channel, config, constraints, resources, revision, base, and units | True |
| `postgresql` | object | Configuration for the postgresql charm including app_name, channel, config, constraints, resources, revision, base, and units | True |
| `haproxy` | object | Configuration for the haproxy charm including app_name, channel, config, constraints, resources, revision, base, and units | True |
| `rabbitmq_server` | object | Configuration for the rabbitmq-server charm including app_name, channel, config, constraints, resources, revision, base, and units | True |

### Outputs

Upon applied, the solution module exports the following outputs:

| Name | Description |
| - | - |
| `model_name` | Name of the Juju model that Landscape Server is deployed on |
| `landscape_account_name` | Account name for Landscape Server (standalone) |
| `registration_key` | Registration key for Landscape Server clients (sensitive) |
| `landscape_root_url` | Root URL for accessing Landscape Server |
| `self_signed_server` | Boolean indicating if using self-signed certificates (sensitive) |
| `admin_email` | Administrator email address |
| `admin_password` | Administrator password (sensitive) |
| `using_smtp` | Boolean indicating if SMTP is configured (sensitive) |
| `applications` | Map containing all deployed application details |

## Notes

- This plan is based on the [`Landscape Server charm bundle`](https://github.com/canonical/landscape-charm/blob/main/bundle-examples/bundle.yaml)
- [Landscape Server charm module](https://github.com/jansdhillon/landscape-charm/tree/tf-charm-module-latest-stable-edge)
- See the plan in action in [a preconfigured, local Landscape demo](https://github.com/jansdhillon/landscape-demo)

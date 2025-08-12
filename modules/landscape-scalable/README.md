# Landscape Server Product Module

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
| `registration_key` | Registration key for Landscape Server clients (sensitive) |
| `landscape_root_url` | Root URL for accessing Landscape Server |
| `admin_email` | Administrator email address |
| `admin_password` | Administrator password (sensitive) |
| `applications` | Map containing all applications (charms) in the module |

## Notes

- This plan is based on the [`Landscape Server charm bundle`](https://github.com/canonical/landscape-charm/blob/main/bundle-examples/bundle.yaml)
- [Landscape Server charm module](https://github.com/jansdhillon/landscape-charm/tree/tf-charm-module-latest-stable-edge)
- See the plan in action in [a preconfigured, local Landscape demo](https://github.com/jansdhillon/landscape-demo)

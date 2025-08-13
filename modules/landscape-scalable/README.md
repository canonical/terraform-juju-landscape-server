# Landscape Server Scalable Product Module

## API

### Inputs

The product module offers the following configurable inputs:

| Name | Type | Description | Required |
| - | - | - | - |
| `arch` | string | CPU architecture | False |
| `create_model` | bool | Allows to skip Juju model creation and re-use a model created in a higher level module | False |
| `credential_name` | string | The name of the Juju credential to use for the model | False |
| `cloud_name` | string | Name of the Juju cloud where the model will operate | False |
| `cloud_region` | string | Region of the Juju cloud where the model will operate | False |
| `domain` | string | Domain name for Landscape Server | False |
| `haproxy` | object | Configuration for the haproxy charm including app_name, channel, config, constraints, resources, revision, base, and units | True |
| `hostname` | string | Hostname for Landscape Server | False |
| `landscape_server` | object | Configuration for the landscape-server charm including app_name, channel, config, constraints, resources, revision, base, and units | True |
| `model` | string | The name of the Juju model to deploy Landscape Server to | True |
| `postgresql` | object | Configuration for the postgresql charm including app_name, channel, config, constraints, resources, revision, base, and units | True |
| `rabbitmq_server` | object | Configuration for the rabbitmq-server charm including app_name, channel, config, constraints, resources, revision, base, and units | True |
| `smtp_host` | string | SMTP server hostname | False |
| `smtp_port` | number | SMTP server port | False |
| `smtp_username` | string | SMTP username | False |
| `smtp_password` | string | SMTP password (sensitive) | False |
| `wait` | bool | Wait for the model to settle as part of the provisioning. Needed if setting up SMTP. | True |

### Outputs

Upon being applied, the module exports the following outputs:

| Name | Description |
| - | - |
| `admin_email` | Administrator email address |
| `admin_password` | Administrator password (sensitive) |
| `applications` | Map containing all applications (charms) in the module |
| `landscape_root_url` | Root URL for accessing Landscape Server |
| `registration_key` | Registration key for Landscape Server clients (sensitive) |
| `self_signed_server` | This deployment is not using custom SSL. |

## Notes

- This plan is based on the [Landscape Server charm bundle](https://github.com/canonical/landscape-charm/blob/main/bundle-examples/bundle.yaml)
- [Landscape Server charm module](https://github.com/canonical/landscape-charm/tree/main/terraform)
- See the plan in action in [a preconfigured, local Landscape demo](https://github.com/jansdhillon/landscape-demo)

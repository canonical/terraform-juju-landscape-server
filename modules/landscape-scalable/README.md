# Landscape Server Scalable Product Module

## API

### Inputs

The product module offers the following configurable inputs:

| Name | Type | Description | Required |
| - | - | - | - |
| `haproxy` | object | Configuration for the haproxy charm including app_name, channel, config, constraints, resources, revision, base, and units | True |
| `landscape_server` | object | Configuration for the landscape-server charm including app_name, channel, config, constraints, resources, revision, base, and units | True |
| `postgresql` | object | Configuration for the postgresql charm including app_name, channel, config, constraints, resources, revision, base, and units | True |
| `haproxy` | object | Configuration for the haproxy charm including app_name, channel, config, constraints, resources, revision, base, and units | True |
| `rabbitmq_server` | object | Configuration for the rabbitmq-server charm including app_name, channel, config, constraints, resources, revision, base, and units | True |

### Outputs

Upon being applied, the module exports the following outputs:

| Name | Description |
| - | - |
| `applications` | Map containing all applications (charms) in the module |
| `admin_email` | The email of the first admin (if set). |
| `admin_password` | The password of the first admin (if set). |
| `registration_key` | Registration key for Landscape Server clients (sensitive) |
| `self_signed_server` | This deployment is not using custom SSL. |

## Notes

- This plan is based on the [Landscape Server charm bundle](https://github.com/canonical/landscape-charm/blob/main/bundle-examples/bundle.yaml)
- [Landscape Server charm module](https://github.com/jansdhillon/landscape-charm/tree/tf-charm-module-latest-stable-edge)
- See the plan in action in [a preconfigured, local Landscape demo](https://github.com/jansdhillon/landscape-demo)

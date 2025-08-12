# Contributing

## Prerequisites

To make contributions to this repository, the following software is needed to be installed in your development environment. Please ensure the following are installed before development.

- Juju >=3.5
- A Juju controller bootstrapped onto a machine cloud
- Terraform
- A model for testing

## Development and Testing

The Terraform module uses the Juju provider to provision Juju resources. Please refer to the [Juju provider documentation](https://registry.terraform.io/providers/juju/juju/latest/docs) for more information.

A Terraform working directory needs to be initialized at the beginning.

Initialise the provider:

```sh
terraform init
```

Format the *.tf files to a canonical format and style:

```sh
terraform fmt
```

Check the syntax:

```sh
terraform validate
```

Preview the changes:

```sh
terraform plan
```

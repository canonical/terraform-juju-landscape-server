# Contributing

## Prerequisites

To make contributions to this repository, the following software is needed to be installed in your development environment. Please [set up your environment][set-up-environment] before development.

- A Kubernetes cluster
- Juju>=3.5
- Juju controller bootstrapped onto the K8s cluster
- Terraform

## Development and Testing

The Terraform module uses the Juju provider to provision Juju resources. Please refer to the [Juju provider documentation](https://registry.terraform.io/providers/juju/juju/latest/docs) for more information.

A Terraform working directory needs to be initialized at the beginning.

Initialise the provider:

```console
terraform init
```

Format the *.tf files to a canonical format and style:

```console
terraform fmt
```

Check the syntax:

```console
terraform validate
```

Preview the changes:

```console
terraform plan
```

[set-up-environment]: [https://discourse.charmhub.io/t/set-up-your-development-environment-with-microk8s-for-juju-terraform-provider/13109]

# SD-Core Terraform Modules

This project contains 3 [Terraform][Terraform] modules to deploy the following SD-Core bundles: [SD-Core][sdcore-k8s], [SD-Core CP][sdcore-control-plane-k8s] and [SD-Core UP][sdcore-user-plane-k8s].

The modules use the [Terraform Juju provider][Terraform Juju provider] to model the bundle deployment onto any Kubernetes environment managed by [Juju][Juju].

`sdcore-k8s` module deploys a standalone 5G core network. This module contains the 5G control plane functions, the UPF, NMS, Grafana Agent, Traefik, Self Signed Certificates and MongoDB.

`sdcore-control-plane-k8s` module deploys the 5G control plane and the `sdcore-user-plane-k8s` module deploys only the 5G user plane. Hence, the SD-Core 5G core network deployment could be performed following the Control and User Plane Separation (CUPS) principles.

## Deploying sdcore-k8s modules with Terraform

In order to deploy SD-Core modules, please follow the instructions in the `README.md` of the module.

[Terraform]: https://www.terraform.io/
[Terraform Juju provider]: https://registry.terraform.io/providers/juju/juju/latest
[Juju]: https://juju.is
[sdcore-k8s]: https://charmhub.io/sdcore-k8s
[sdcore-control-plane-k8s]: https://charmhub.io/sdcore-control-plane-k8s
[sdcore-user-plane-k8s]: https://charmhub.io/sdcore-user-plane-k8

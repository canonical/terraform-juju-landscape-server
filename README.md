# terraform-landscape-server

## Configure a Juju cloud

This module requires that a Juju cloud is already initialized with a credential for it defined and accesible.
For example, to use `localhost`:

```sh
juju boostrap localhost landscape-controller
```

If not using `localhost`, you must set the `cloud_name`, `cloud_region`, and `credential_name` variables in `terraform.tfvars.example`.

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

### (Optional) Use a custom SSL certificate

```sh
terraform apply \
-var "b64_ssl_cert=$(sudo base64 fullchain.pem)" \
-var "b64_ssl_key=$(sudo base64 privkey.pem)"
```

where `fullchain.pem` and `privkey.pem` are the paths of the public and private key of the SSL certificate.

## Notes

- This plan is currently based on the [`latest-stable`](https://github.com/canonical/landscape-bundles/tree/scalable-stable) version of the Landscape Server Charm Bundle
- See the plan in action in [a preconfigured, local Landscape demo](https://github.com/jansdhillon/landscape-demo)

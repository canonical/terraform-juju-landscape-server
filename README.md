# terraform-landscape-server

Initialize the module:

```sh
terraform init
```

Plan:

```sh
terraform plan
```

Apply the plan:

```sh
terraform apply
```

Using custom SSL:

```sh
terraform apply -var="ssl_key_content=$(sudo cat privkey.pem)" -var="ssl_cert_content=$(sudo cat fullchain.pem)"
```

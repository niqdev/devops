# Terraform

> **Terraform** is an infrastructure as code tool that lets you build, change, and version infrastructure safely and efficiently

Resources

* [Terraform in Action](https://www.manning.com/books/terraform-in-action)
* [Documentation](https://developer.hashicorp.com/terraform)
* [Terraform Registry](https://registry.terraform.io)

Setup
```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

terraform version
```

Terraform's core building blocks:

* `terraform` Terraform's own settings (required version, providers, backend/state config)
* `provider` tells Terraform which cloud/API to talk to and how to authenticate
* `resource` something Terraform creates/updates/deletes e.g. VM, subnet, bucket
* `data` something Terraform reads only (already exists)
* `variable` input values for your config (like function arguments)
* `locals` internal named values/calculations to avoid repeating logic
* `output` values Terraform prints after apply (and exposes to parent modules)
* `module` reusable Terraform package/folder you call from another config

Docker example
```sh
# formatting/linting
terraform fmt -check 

# initializing a configuration directory downloads and installs the providers defined in the configuration
cd terraform/docker-example
terraform init

# validatiom
terraform validate
# dry run
terraform plan

# with rancher desktop
terraform plan -var="docker_host=unix:///${HOME}/.rd/docker.sock"
# apply with "TF_VAR_<name>" convention
TF_VAR_docker_host="unix:///${HOME}/.rd/docker.sock" terraform apply -auto-approve
# cleanup
terraform destroy -var="docker_host=unix:///${HOME}/.rd/docker.sock"

# verify state
terraform show
terraform state list

# http://localhost:8080
terraform output -json

# controlled/appoved deployments (binary format)
terraform plan -out=plan.out
terraform show -json plan.out
terraform apply plan.out
```

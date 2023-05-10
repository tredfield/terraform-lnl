# Setup

Below are steps for basic terraform setup locally

I highly recommend you use a package manager such as `brew` for mac or `choco` for windows.

See:

- <https://chocolatey.org/install>
- <https://brew.sh/>

## Install Terraform

```bash
# mac
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
brew install jq
```

``` bash
# windows
choco install terraform
choco install jq
```

## Local AWS Setup

For running terraform locally you need to provide credentials for most Terraform providers. This typically can be done via environment variables. Here is how to setup AWS

Note I use <https://www.passwordstore.org> below for retrieving secrets locally

1. Export AWS credentials

```bash
export AWS_ACCESS_KEY_ID=AKIAQINXMUNZQOZILKJS
export AWS_SECRET_ACCESS_KEY=$(pass /work/slalom/TerraformDemo/AKIAQINXMUNZQOZILKJS)
```

Depending on your client there may be other tools needed to retrieve user key credentials

!!! tip
    VS Code has great terraform extensions. A must is `HashiCorp Terraform` extension

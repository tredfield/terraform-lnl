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

!!! tip
    VS Code has great terraform extensions. A must is `HashiCorp Terraform` extension

## Local AWS Setup

For running terraform locally you need to provide credentials for most Terraform providers. This typically can be done via environment variables. Here is how to setup AWS

!!! tip
    I use <https://www.passwordstore.org> below for retrieving secrets locally

Export AWS credentials

```bash
export AWS_ACCESS_KEY_ID=AKIAQINXMUNZQOZILKJS
export AWS_SECRET_ACCESS_KEY=$(pass /work/slalom/TerraformDemo/AKIAQINXMUNZQOZILKJS)
```

!!! warning
    Using AWS user access keys is not very secure because they are long lived and can be leaked. There are several approaches to retrieve temporary credentials. Work with your client to make sure you are using the most secure approach

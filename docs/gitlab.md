# Gitlab Pipelines

Now lets setup a gitlab pipeline to run Terraform!

## .gitlab-ci.yml

!!! info
    Gitlab pipelines are configured via a yaml file called `.gitlab-ci.yml`

First step is we will need to configure our `.gitlab-ci.yml`

!!! tip
    Gitlab also needs to access your AWS account. There are several ways to do this. The easiest being setting CI/CD variables for `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. However, there are more secure ways and your client may have already integrated AWS with Gitlab

Here is our `.gitlab-ci.yml` file

```yml
put here
```

Ok lets push this to gitlab and see what happens

We see it is runs a plan but wants to re-create all the resources. Gitlab doesn't know about the resources we have created because by default we have been using local state. Lets fix that!

## Configure gitlab to use remote backend

In `main.tf` update the `terraform` block to include the below. This tells terraform to use http backend to store state

```
  backend "http" {
  }
```

Now we need to migrate local state to gitlab. You need to create a gitlab personal access token to do this, see <https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html>

!!! note
    Token needs to have `api` scope

Use the script below setting the `PROJECT_ID` to the corresponding gitlab project and `TF_USERNAME` to your gitlab username

```bash
PROJECT_ID="45873656"
TF_USERNAME="travis.redfield"
TF_PASSWORD="$(pass /work/slalom/gitlab/travis.redfield/token)"
TF_ADDRESS="https://gitlab.com/api/v4/projects/${PROJECT_ID}/terraform/state/default"

terraform init \
  -backend-config=address=${TF_ADDRESS} \
  -backend-config=lock_address=${TF_ADDRESS}/lock \
  -backend-config=unlock_address=${TF_ADDRESS}/lock \
  -backend-config=username=${TF_USERNAME} \
  -backend-config=password=${TF_PASSWORD} \
  -backend-config=lock_method=POST \
  -backend-config=unlock_method=DELETE \
  -backend-config=retry_wait_min=5
```
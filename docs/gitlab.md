# Gitlab Pipelines

Now lets setup a gitlab pipeline to run Terraform!

## .gitlab-ci.yml

!!! info
    Gitlab pipelines are configured via a yaml file called `.gitlab-ci.yml`

First step is we will need to configure our `.gitlab-ci.yml`

!!! tip
    Gitlab also needs to access your AWS account. There are several ways to do this. The easiest being setting CI/CD variables for `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. However, there are more secure ways and your client may have already integrated AWS with Gitlab

## What is Terraform?

Terraform is a Infrastructure as Code tool… that is a mouthful

- With IaC you “declare” how you want your infrastructure to be. Tools like Terraform make it so
- This is much different than how tools of the past provisioned infrastructure that more or less used scripts or “instructions”
Older tools are usually procedural
- Terraform is a CLI (command line interface) but often used in automation CI/CD platforms

```bash
❯ terraform
Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by
less common or more advanced commands.

Main commands:
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure
```

## Great, but is Terraform worth it?

- Writing terraform code your first time is probably going to seem like a PITA, why not just use the console?
- Terraform is repeatable! Your client will think you are a superhero when they ask if you can create yet another new environment and you say “yes, just give me a few minutes”
- Terraform gives you a chance to review the changes that will be made before they are applied. And changes are easy to rollback
- In a disaster you can easily recover an environment in very little time
- Terraform prevents infrastructure drift
- Being it is code, you check it into git and have the same accountability, history, etc

## Why Choose Terraform?

What about CloudFormation, CDK, Pulumi?

- CloudFormation and AWS Cloud Development Kit (CDK) are viable tools if you are only working with AWS
- Terraform has the advantage of being cloud agnostic and allows you to provision across multiple cloud providers
- Terraform also works for more than just provisioning infrastructure:
    - Manage Kubernetes
    - Salesforce
    - On-prem resources
    - Databases
    - Security and Authentication
    - Policy as Code
    - Much more!
- Terraform now has CDK! This allows you to write terraform in TypeScript, Python, Java, C#, and Go
- What about Pulumi? Pulumi is a great choice as well. Similar to CDK Pulumi allows you to write infrastructure in many programming languages

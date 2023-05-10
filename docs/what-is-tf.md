{==

Terraform is a Infrastructure as Code tool that automates creating your infrastructure

==}

- With `IaC` you “declare” how you want your infrastructure to be. Tools like Terraform make it so
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
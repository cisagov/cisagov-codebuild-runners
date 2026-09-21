# cisagov-codebuild-runners #

[![GitHub Build Status](https://github.com/cisagov/cisagov-codebuild-runners/workflows/build/badge.svg)](https://github.com/cisagov/cisagov-codebuild-runners/actions)
[![License](https://img.shields.io/github/license/cisagov/cisagov-codebuild-runners)](https://spdx.org/licenses/)
[![CodeQL](https://github.com/cisagov/cisagov-codebuild-runners/workflows/CodeQL/badge.svg)](https://github.com/cisagov/cisagov-codebuild-runners/actions/workflows/codeql-analysis.yml)

This is a Terraform project for setting up ephemeral, self-hosted
GitHub Actions runners in AWS CodeBuild.

## Prerequisites ##

### GitHub permissions ###

The Terraform GitHub provider leverages your local `gh` CLI tool's
authentication; hence, for the provider to make the necessary GitHub
organization changes you will need to set up your local `gh` client
with organization-level permissions:

```console
gh auth refresh --scopes admin:org
```

After deploying this Terraform code you can re-authenticate to return
to the default minimum scope:

```console
gh auth refresh --reset-scopes
```

### Complete connection between AWS and GitHub ###

After creating the AWS CodeConnections resource via Terraform, you
must [update the pending connection between AWS and
GitHub](https://docs.aws.amazon.com/dtconsole/latest/userguide/connections-update.html).
There is no way to do this using Terraform or the AWS CLI, and the
rest of the deployment will fail until you do this.

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
| ---- | ------- |
| terraform | ~> 1.1 |
| aws | ~> 6.64 |
| github | ~> 6.13 |

## Providers ##

| Name | Version |
| ---- | ------- |
| aws | ~> 6.64 |
| aws.userservicesprovisionaccount | ~> 6.64 |
| github | ~> 6.13 |
| terraform | n/a |

## Modules ##

| Name | Source | Version |
| ---- | ------ | ------- |
| github\_runner | cloudandthings/github-runners/aws | 4.1.0 |

## Resources ##

| Name | Type |
| ---- | ---- |
| [aws_codeconnections_connection.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codeconnections_connection) | resource |
| [aws_iam_policy.provisionrunners_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.provisionrunners_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [github_actions_runner_group.codebuild](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_runner_group) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.user_services](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.provisionrunners_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [github_repository.runner](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository) | data source |
| [terraform_remote_state.userservices](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| aws\_region | The AWS region in which to deploy the CodeBuild runners (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| build\_timeout | Number of minutes before a CodeBuild-hosted GitHub Actions runner times out. | `number` | `480` | no |
| github\_organization | GitHub organization containing the repositories. | `string` | n/a | yes |
| provisionaccount\_role\_name | The name of the IAM role that allows sufficient permissions to provision all AWS resources in the User Services account. | `string` | `"ProvisionAccount"` | no |
| provisionrunners\_policy\_description | The description to associate with the IAM policy that allows provisioning of CodeBuild GitHub runners in the User Services account. | `string` | `"Allows provisioning of CodeBuild GitHub runners in the User Services account."` | no |
| provisionrunners\_policy\_name | The name to assign the IAM policy that allows provisioning of CodeBuild GitHub runners in the User Services account. | `string` | `"ProvisionCodeBuildRunners"` | no |
| runner\_group\_name | Name of the GitHub Actions runner group. | `string` | `"codebuild"` | no |
| runner\_repositories | GitHub repositories allowed to use the CodeBuild runners. | `set(string)` | n/a | yes |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| terraform\_state\_bucket | The name of the S3 bucket where Terraform state is stored. | `string` | n/a | yes |

## Outputs ##

| Name | Description |
| ---- | ----------- |
| codebuild\_runners | The CodeBuild runners. |
| github\_actions\_runner\_group | The group of repos allowed to use the CodeBuild runners. |
| github\_connection | The connection between GitHub and AWS CodeBuild. |
| provisionrunners\_policy | The IAM policy that allows for creation of CodeBuild GitHub runners. |
| provisionrunners\_policy\_attachment | The attachment for the IAM policy that allows for creation of CodeBuild GitHub runners. |
<!-- END_TF_DOCS -->

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is only the main directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.

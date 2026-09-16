# cisagov-codebuild-runners #

[![GitHub Build Status](https://github.com/cisagov/cisagov-codebuild-runners/workflows/build/badge.svg)](https://github.com/cisagov/cisagov-codebuild-runners/actions)
[![License](https://img.shields.io/github/license/cisagov/cisagov-codebuild-runners)](https://spdx.org/licenses/)
[![CodeQL](https://github.com/cisagov/cisagov-codebuild-runners/workflows/CodeQL/badge.svg)](https://github.com/cisagov/cisagov-codebuild-runners/actions/workflows/codeql-analysis.yml)

This is a generic skeleton project that can be used to quickly get a
new [cisagov](https://github.com/cisagov) [Terraform
module](https://www.terraform.io/docs/modules/index.html) GitHub
repository started.  This skeleton project contains [licensing
information](LICENSE), as well as [pre-commit
hooks](https://pre-commit.com) and
[GitHub Actions](https://github.com/features/actions) configurations
appropriate for the major languages that we use.

See the [Terraform
documentation](https://www.terraform.io/docs/modules/index.html) for
more details on Terraform modules and the standard module structure.

## Usage ##

```hcl
module "example" {
  source = "github.com/cisagov/cisagov-codebuild-runners?ref=v0.0.1"

  aws_region            = "us-west-1"
  aws_availability_zone = "b"
  subnet_id             = "subnet-0123456789abcdef0"
}
```

## Examples ##

- [Basic usage](https://github.com/cisagov/cisagov-codebuild-runners/tree/develop/examples/basic_usage)

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
| [aws_iam_policy.provisionrunners_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.provisionrunners_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [github_actions_runner_group.codebuild](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_runner_group) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.provisionrunners_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [github_repository.runner](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository) | data source |
| [terraform_remote_state.userservices](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| aws\_region | The AWS region in which to deploy the CodeBuild runners (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| github\_codeconnection\_arn | ARN of the AWS CodeConnections GitHub App connection. | `string` | n/a | yes |
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
| provisionrunners\_policy | The IAM policy that allows for creation of CodeBuild GitHub runners. |
| provisionrunners\_policy\_attachment | The attachment for the IAM policy that allows for creation of CodeBuild GitHub runners. |
<!-- END_TF_DOCS -->

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, these are the main directory and
every directory under `examples/`.

## New Repositories from a Skeleton ##

Please see our [Project Setup guide](https://github.com/cisagov/development-guide/tree/develop/project_setup)
for step-by-step instructions on how to start a new repository from
a skeleton. This will save you time and effort when configuring a
new repository!

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

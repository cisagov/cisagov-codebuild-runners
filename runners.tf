module "github_runner" {
  for_each = local.architectures
  providers = {
    aws = aws.userservicesprovisionaccount
  }

  source  = "cloudandthings/github-runners/aws"
  version = "4.1.0"

  build_timeout = var.build_timeout
  name          = "${var.github_organization}-${each.key}"

  # Use an organization-level GitHub webhook.
  source_location     = "CODEBUILD_DEFAULT_WEBHOOK_SOURCE_LOCATION"
  source_organization = var.github_organization

  # Architecture-specific CodeBuild environment.
  environment_compute_type = each.value.compute_type
  environment_image        = each.value.environment_image
  environment_type         = each.value.environment_type

  # AWS CodeConnections GitHub App.
  github_codeconnection_arn = aws_codeconnections_connection.github.arn

  # Register runners at the organization level and put them
  # into our restricted GitHub Actions runner group.
  environment_variables = [
    {
      name  = "CODEBUILD_CONFIG_GITHUB_ACTIONS_ORG_REGISTRATION_NAME"
      value = var.github_organization
      type  = "PLAINTEXT"
    },
    {
      name  = "CODEBUILD_CONFIG_GITHUB_ACTIONS_RUNNER_GROUP_ID"
      value = tostring(github_actions_runner_group.codebuild.id)
      type  = "PLAINTEXT"
    },
  ]

  # Only launch a runner for workflow jobs from the repositories
  # in var.runner_repositories.
  webhook_filter_groups = [
    [
      {
        type    = "EVENT"
        pattern = "WORKFLOW_JOB_QUEUED"
      },
      {
        type    = "REPOSITORY_NAME"
        pattern = local.runner_repositories_regex
      },
    ],
  ]
}

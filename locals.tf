locals {
  architectures = {
    amd64 = {
      environment_type  = "LINUX_CONTAINER"
      environment_image = "aws/codebuild/standard:8.0"
    }

    arm64 = {
      environment_type  = "ARM_CONTAINER"
      environment_image = "aws/codebuild/amazonlinux-aarch64-standard:3.0"
    }
  }

  # Extract the user name of the current caller for use
  # as assume role session names.
  caller_user_name = split("/", data.aws_caller_identity.current.arn)[1]

  runner_repositories_regex = format(
    "^(%s)$",
    join("|", sort(tolist(var.runner_repositories))),
  )
}

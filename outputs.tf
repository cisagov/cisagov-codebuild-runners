output "codebuild_runners" {
  description = "The CodeBuild runners."
  value       = module.github_runner
}

output "github_actions_runner_group" {
  description = "The group of repos allowed to use the CodeBuild runners."
  value       = github_actions_runner_group.codebuild
}

output "github_connection" {
  description = "The connection between GitHub and AWS CodeBuild."
  value       = aws_codeconnections_connection.github
}

output "provisionrunners_policy" {
  description = "The IAM policy that allows for creation of CodeBuild GitHub runners."
  value       = aws_iam_policy.provisionrunners_policy
}

output "provisionrunners_policy_attachment" {
  description = "The attachment for the IAM policy that allows for creation of CodeBuild GitHub runners."
  value       = aws_iam_role_policy_attachment.provisionrunners_policy_attachment
}

data "github_repository" "runner" {
  for_each = var.runner_repositories

  full_name = "${var.github_organization}/${each.value}"
}

resource "github_actions_runner_group" "codebuild" {
  name       = var.runner_group_name
  visibility = "selected"

  selected_repository_ids = [
    for repository in data.github_repository.runner :
    repository.repo_id
  ]
}

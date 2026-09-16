# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary
# to provision CodeBuild GitHub runners in the User Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionrunners_policy_doc" {
  # This policy needs to be more restricted, obviously
  statement {
    actions = [
      "codebuild:BatchGetProjects",
      "codebuild:CreateProject",
      "codebuild:CreateWebhook",
      "codebuild:DeleteProject",
      "codebuild:DeleteSourceCredentials",
      "codebuild:ImportSourceCredentials",
      "codebuild:ListSourceCredentials",
      "codebuild:UpdateProject",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "provisionrunners_policy" {
  provider = aws.userservicesprovisionaccount

  description = var.provisionrunners_policy_description
  name        = var.provisionrunners_policy_name
  policy      = data.aws_iam_policy_document.provisionrunners_policy_doc.json
}

# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary
# to provision CodeBuild GitHub runners in the User Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionrunners_policy_doc" {
  statement {
    actions = [
      "codebuild:BatchGetProjects",
      "codebuild:CreateProject",
      "codebuild:CreateWebhook",
      "codebuild:DeleteProject",
      "codebuild:DeleteWebhook",
      "codebuild:DeleteSourceCredentials",
      "codebuild:ImportSourceCredentials",
      "codebuild:ListSourceCredentials",
      "codebuild:UpdateProject",
      "codebuild:UpdateWebhook",

      "codeconnections:CreateConnection",
      "codeconnections:DeleteConnection",
      "codeconnections:GetConnection",
      "codeconnections:ListTagsForResource",
      "codeconnections:TagResource",
      "codeconnections:UntagResource",
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

# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary
# to provision CodeBuild GitHub runners in the User Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionrunners_policy_doc" {
  dynamic "statement" {
    for_each = local.architectures

    content {
      actions = [
        "codebuild:BatchGetProjects",
        "codebuild:CreateProject",
        "codebuild:CreateWebhook",
        "codebuild:DeleteProject",
        "codebuild:DeleteWebhook",
        "codebuild:UpdateProject",
        "codebuild:UpdateWebhook",
      ]
      effect = "Allow"
      resources = [
        "arn:aws:codebuild:${var.aws_region}:${data.aws_caller_identity.user_services.account_id}:project/${var.github_organization}-${statement.key}",
      ]
    }
  }

  statement {
    actions = [
      "codebuild:DeleteSourceCredentials",
      "codebuild:ImportSourceCredentials",
      "codebuild:ListSourceCredentials",
    ]
    effect = "Allow"
    # These actions don't take any resources, but Terraform requires
    # that resources be present in a statement block.
    resources = ["*"]
  }

  # The connection ARN includes the connection ID, which we can't know
  # until the connection is actually created; therefore, there is no
  # way to specify the resource more specifically that what is already
  # being done here.
  statement {
    actions = [
      "codeconnections:CreateConnection",
      "codeconnections:DeleteConnection",
      "codeconnections:GetConnection",
      "codeconnections:ListTagsForResource",
      "codeconnections:TagResource",
      "codeconnections:UntagResource",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:codeconnections:${var.aws_region}:${data.aws_caller_identity.user_services.account_id}:connection/*",
    ]
  }
}

resource "aws_iam_policy" "provisionrunners_policy" {
  provider = aws.userservicesprovisionaccount

  description = var.provisionrunners_policy_description
  name        = var.provisionrunners_policy_name
  policy      = data.aws_iam_policy_document.provisionrunners_policy_doc.json
}

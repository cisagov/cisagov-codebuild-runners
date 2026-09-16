# ------------------------------------------------------------------------------
# Attach to the ProvisionAccount role the IAM policy that allows
# provisioning of CodeBuild GitHub runners in the User Services
# account.
# ------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "provisionrunners_policy_attachment" {
  provider = aws.userservicesprovisionaccount

  policy_arn = aws_iam_policy.provisionrunners_policy.arn
  role       = var.provisionaccount_role_name
}

# Note that this resource will be created in the "pending" state, so
# after creation you must update the connection via the AWS console as
# described here:
# https://docs.aws.amazon.com/dtconsole/latest/userguide/connections-update.html
resource "aws_codeconnections_connection" "github" {
  provider = aws.userservicesprovisionaccount

  name          = "${var.github_organization}-github-connection"
  provider_type = "GitHub"
}

# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------
variable "github_organization" {
  description = "GitHub organization containing the repositories."
  nullable    = false
  type        = string
}

variable "github_codeconnection_arn" {
  description = "ARN of the AWS CodeConnections GitHub App connection."
  nullable    = false
  type        = string
}

variable "runner_repositories" {
  description = "GitHub repositories allowed to use the CodeBuild runners."
  nullable    = false
  type        = set(string)
}

variable "terraform_state_bucket" {
  description = "The name of the S3 bucket where Terraform state is stored."
  nullable    = false
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------
variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region in which to deploy the CodeBuild runners (e.g. us-east-1)."
  nullable    = false
  type        = string
}

variable "provisionaccount_role_name" {
  default     = "ProvisionAccount"
  description = "The name of the IAM role that allows sufficient permissions to provision all AWS resources in the User Services account."
  nullable    = false
  type        = string
}

variable "provisionrunners_policy_description" {
  default     = "Allows provisioning of CodeBuild GitHub runners in the User Services account."
  description = "The description to associate with the IAM policy that allows provisioning of CodeBuild GitHub runners in the User Services account."
  nullable    = false
  type        = string
}

variable "provisionrunners_policy_name" {
  default     = "ProvisionCodeBuildRunners"
  description = "The name to assign the IAM policy that allows provisioning of CodeBuild GitHub runners in the User Services account."
  nullable    = false
  type        = string
}

variable "runner_group_name" {
  default     = "codebuild"
  description = "Name of the GitHub Actions runner group."
  nullable    = false
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to all AWS resources created."
  nullable    = false
  type        = map(string)
}

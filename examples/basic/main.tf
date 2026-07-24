terraform {
  required_version = ">= 1.9"
}

module "gitlab_onboarding" {
  source = "../../"

  gitlab_instance_name = var.gitlab_instance_name
  jwt_issuer           = var.jwt_issuer
  oidc_discovery_url   = var.oidc_discovery_url
}

variable "gitlab_instance_name" {
  type        = string
  description = "GitLab instance identifier."
}

variable "jwt_issuer" {
  type        = string
  description = "GitLab OIDC issuer URL."
  default     = ""
}

variable "oidc_discovery_url" {
  type        = string
  description = "GitLab OIDC discovery URL."
}

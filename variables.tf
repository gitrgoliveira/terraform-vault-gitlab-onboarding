variable "default_lease_ttl" {
  type        = string
  description = "Default lease TTL for the JWT auth backend tune block."
  default     = "1h"
}

variable "gitlab_instance_name" {
  type        = string
  description = "GitLab instance scope used in trust mount naming."

  validation {
    condition     = contains(["cloud", "dedicated-prod", "dedicated-dev"], var.gitlab_instance_name)
    error_message = "gitlab_instance_name must be one of: cloud, dedicated-prod, dedicated-dev."
  }
}

variable "jwks_url" {
  type        = string
  description = "Optional JWKS URL for JWT signature verification."
  default     = ""
}

variable "jwt_issuer" {
  type        = string
  description = "Optional GitLab OIDC issuer (bound_issuer). Derived from oidc_discovery_url when empty."
  default     = ""
}

variable "jwt_validation_pubkey" {
  type        = string
  description = "Single PEM public key for JWT validation. Leave empty to use OIDC discovery or JWKS URL instead."
  default     = ""
}

variable "max_lease_ttl" {
  type        = string
  description = "Maximum lease TTL for the JWT auth backend tune block."
  default     = "24h"
}

variable "oidc_discovery_url" {
  type        = string
  description = "OIDC discovery URL for JWT auth backend config. Set exactly one of oidc_discovery_url, jwks_url, or jwt_validation_pubkey."
  default     = ""

  validation {
    condition = (
      (var.oidc_discovery_url != "" ? 1 : 0) +
      (var.jwks_url != "" ? 1 : 0) +
      (var.jwt_validation_pubkey != "" ? 1 : 0)
    ) == 1
    error_message = "Set exactly one of oidc_discovery_url, jwks_url, or jwt_validation_pubkey."
  }
}

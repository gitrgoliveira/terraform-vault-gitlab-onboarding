provider "vault" {
  skip_child_token = true
}

locals {
  # Normalise discovery URL: accept with or without the .well-known component and trailing slash.
  # GitLab's issuer is the base URL with any /.well-known/... suffix removed.
  derived_issuer = trimsuffix(split("/.well-known", var.oidc_discovery_url)[0], "/")
  bound_issuer   = var.jwt_issuer != "" ? var.jwt_issuer : local.derived_issuer
}

resource "vault_jwt_auth_backend" "this" {
  path                   = "jwt-gitlab/${var.gitlab_instance_name}"
  bound_issuer           = local.bound_issuer
  oidc_discovery_url     = var.oidc_discovery_url != "" ? local.derived_issuer : null
  jwks_url               = var.jwks_url != "" ? var.jwks_url : null
  jwt_validation_pubkeys = length(var.jwt_validation_pubkeys) > 0 ? var.jwt_validation_pubkeys : null

  tune {
    default_lease_ttl = var.default_lease_ttl
    max_lease_ttl     = var.max_lease_ttl
  }
}

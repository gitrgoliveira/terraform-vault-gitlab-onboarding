mock_provider "vault" {}

run "multiple_jwt_verification_sources_fail_validation" {
  command = plan

  variables {
    bound_audiences    = ["https://gitlab.com"]
    gitlab_instance    = "dev-cluster"
    jwt_issuer         = "https://gitlab.com"
    oidc_discovery_url = "https://gitlab.com"
    jwks_url           = "https://gitlab.com/oauth/discovery/keys"
  }

  expect_failures = [
    var.oidc_discovery_url,
  ]
}

run "invalid_gitlab_instance_fails_validation" {
  command = plan

  variables {
    bound_audiences    = ["https://gitlab.com"]
    gitlab_instance    = "-bad"
    jwt_issuer         = "https://gitlab.com"
    oidc_discovery_url = "https://gitlab.com"
  }

  expect_failures = [
    var.gitlab_instance,
  ]
}

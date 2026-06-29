mock_provider "vault" {}

run "defaults_plan_succeeds_with_oidc" {
  command = plan

  variables {
    bound_audiences    = ["https://gitlab.com"]
    cluster_name       = "dev-cluster"
    jwt_issuer         = "https://gitlab.com"
    oidc_discovery_url = "https://gitlab.com"
  }

  assert {
    condition     = output.cluster_name == "dev-cluster"
    error_message = "cluster_name output should echo input."
  }

  assert {
    condition     = jsonencode(output.bound_audiences) == jsonencode(["https://gitlab.com"])
    error_message = "bound_audiences output should echo input."
  }

  assert {
    condition     = output.jwt_auth_path == "jwt-gitlab/dev-cluster"
    error_message = "jwt_auth_path should use jwt-gitlab/<cluster_name> naming."
  }
}

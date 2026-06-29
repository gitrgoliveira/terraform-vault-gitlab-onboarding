# terraform-vault-gitlab-onboarding

Trust-layer module that creates one Vault JWT auth backend at `jwt-gitlab/<gitlab_instance_name>` for GitLab.

## Layer

Trust. This module creates trust only. It does not create principals, policies, or secret engines.

## Prerequisites

- HCP Terraform project configured with Vault dynamic credentials (`TFC_VAULT_*`)
- Tenant namespace inherited through `VAULT_NAMESPACE`

## No-code notes

- This module is no-code ready and declares its own `vault` provider.
- It creates trust only and outputs values for principal modules.
- It uses a separate mount path from OCP trust (`jwt-gitlab/<gitlab_instance_name>`).

## Inputs

| Name | Type | Description |
|---|---|---|
| `gitlab_instance_name` | `string` | One of `cloud`, `dedicated_prod`, `dedicated_dev` |
| `jwt_issuer` | `string` | GitLab OIDC issuer URL |
| `oidc_discovery_url` | `string` | Optional discovery URL, mutually exclusive |
| `jwks_url` | `string` | Optional JWKS URL, mutually exclusive |
| `jwt_validation_pubkeys` | `list(string)` | Optional PEM keys, mutually exclusive |
| `bound_audiences` | `list(string)` | Echoed for downstream principal role binding, default `["vault"]` |
| `default_lease_ttl` | `string` | Tune default TTL, default `1h` |
| `max_lease_ttl` | `string` | Tune max TTL, default `24h` |
| `vault_namespace` | `string` | Render-only, default `""` |
| `vault_address` | `string` | Render-only, default `""` |

## Outputs

| Name | Description |
|---|---|
| `jwt_auth_path` | JWT mount path (`jwt-gitlab/<gitlab_instance_name>`) |
| `jwt_mount_accessor` | JWT mount accessor for entity alias creation |
| `gitlab_instance_name` | Echo |
| `bound_audiences` | Echo |
| `vault_namespace` | Echo |
| `vault_address` | Echo |

## No-code provisioning

This module is no-code enabled in the `hc-ric-demo` private registry (pinned to `0.0.3`). Click **Provision workspace**, pick a project and workspace name, then complete the form. `gitlab_instance_name` is presented as a **dropdown** limited to `cloud`, `dedicated_prod`, `dedicated_dev`.

Form fields:

| Field | Required | Notes |
|---|---|---|
| `gitlab_instance_name` | yes | Dropdown: `cloud` / `dedicated_prod` / `dedicated_dev` |
| `jwt_issuer` | yes | GitLab OIDC issuer URL |
| `oidc_discovery_url` / `jwks_url` / `jwt_validation_pubkeys` | yes | Set exactly one |
| `bound_audiences` | no | Default `["vault"]` |

## Registry usage

```hcl
module "gitlab_onboarding" {
  source  = "app.terraform.io/<org>/gitlab-onboarding/vault"
  version = "~> 0.1"

  gitlab_instance_name = "cloud"
  jwt_issuer         = "https://gitlab.com"
  oidc_discovery_url = "https://gitlab.com"
  bound_audiences    = ["https://vault.example.com"]
}
```

Next step in chain: `terraform-vault-add-gitlab-project-access`.

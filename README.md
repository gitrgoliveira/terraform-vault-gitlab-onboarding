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
| `oidc_discovery_url` | `string` | Discovery URL, mutually exclusive; accepts base or `.well-known` form, normalised automatically |
| `jwt_issuer` | `string` | Optional `bound_issuer`; derived from `oidc_discovery_url` when empty |
| `jwks_url` | `string` | Optional JWKS URL, mutually exclusive |
| `jwt_validation_pubkeys` | `list(string)` | Optional PEM keys, mutually exclusive |
| `default_lease_ttl` | `string` | Tune default TTL, default `1h` |
| `max_lease_ttl` | `string` | Tune max TTL, default `24h` |

## Outputs

| Name | Description |
|---|---|
| `jwt_auth_path` | JWT mount path (`jwt-gitlab/<gitlab_instance_name>`) |
| `jwt_mount_accessor` | JWT mount accessor for entity alias creation |
| `gitlab_instance_name` | Echo |

## No-code provisioning

This module is no-code enabled in the `hc-ric-demo` private registry (pinned to `0.1.0`). Click **Provision workspace**, pick a project and workspace name, then complete the form. `gitlab_instance_name` is presented as a **dropdown** limited to `cloud`, `dedicated_prod`, `dedicated_dev`.

> **No-code UX note:** The `gitlab_instance_name` dropdown is driven by explicit no-code `variable-options` configured on the module in the registry, not by the module's `contains()` validation (which only validates on submit). These options (`cloud`, `dedicated_prod`, `dedicated_dev`) are a registry-side setting applied via the `tfe_no_code_module` resource or the no-code modules API. They are not stored in this repository, so re-enabling no-code provisioning for the module requires re-applying them.

Form fields:

| Field | Required | Notes |
|---|---|---|
| `gitlab_instance_name` | yes | Dropdown: `cloud` / `dedicated_prod` / `dedicated_dev` |
| `oidc_discovery_url` / `jwks_url` / `jwt_validation_pubkeys` | yes | Set exactly one; discovery URL accepts base or `.well-known` form |
| `jwt_issuer` | no | Derived from `oidc_discovery_url` when empty |

## Registry usage

```hcl
module "gitlab_onboarding" {
  source  = "app.terraform.io/<org>/gitlab-onboarding/vault"
  version = "~> 0.1.0"

  gitlab_instance_name = "cloud"
  oidc_discovery_url = "https://gitlab.com"
}
```

Next step in chain: `terraform-vault-add-gitlab-project-access`.

# Changelog

All notable changes to this project are documented in this file.

## [0.3.0] - 2026-07-24

### Changed
- **Breaking:** `gitlab_instance_name` enum values changed from `dedicated_prod`/`dedicated_dev` to `dedicated-prod`/`dedicated-dev` (hyphens instead of underscores) for consistency with the project identifier regex. No-code dropdown options must be updated in the registry.

## [0.2.0] - 2026-07-24

### Changed
- **Breaking:** renamed `jwt_validation_pubkeys` (type `list(string)`) to `jwt_validation_pubkey` (type `string`). Callers passing a list must now pass a single PEM key string.
- Added `default = ""` to `oidc_discovery_url` so non-OIDC paths no longer require passing an empty string explicitly.
- Added `default = ""` to `jwt_issuer` in the basic example so the example validates without a tfvars entry for `jwt_issuer`.
- Fixed alphabetical ordering of variables in `variables.tf`.

## [0.1.1] - 2026-07-07

### Changed
- Documentation: renamed the "principal" layer references to "workload" to match the onboarding terminology (no input/output or behavior change).

## [0.1.0] - 2026-07-07

### Removed
- **Breaking:** removed the `bound_audiences`, `vault_address`, and `vault_namespace` input variables and their echo outputs. These inputs were echoed straight back as outputs and did no work in the module; downstream principal modules already request these values as their own inputs.

## [0.0.6] - 2026-06-29

### Changed
- Documentation fix: corrected the registry-usage version constraint and no-code registry pin to `0.0.6`.

## [0.0.5] - 2026-06-29

### Changed
- Made `jwt_issuer` optional; `bound_issuer` is now derived from `oidc_discovery_url` when empty.
- `oidc_discovery_url` now accepts base or `.well-known` URLs and is normalised (any `/.well-known/...` suffix and trailing slash stripped).

## [0.0.4] - 2026-06-29

### Changed
- Removed default from `oidc_discovery_url` so it becomes a required input in the no-code form, preventing the "set exactly one" validation error when all sources are left empty.

## [0.0.3] - 2026-06-29

### Changed
- Renamed `gitlab_instance` to `gitlab_instance_name` and restricted values to `cloud`, `dedicated_prod`, `dedicated_dev`.

## [0.0.2] - 2026-06-29

### Changed
- Renamed `cluster_name` input/output to `gitlab_instance` to reflect that GitLab is a CI/CD platform with no cluster concept. Breaking change for consumers of v0.0.1.

## [0.0.1]

### Added
- Initial no-code-ready module implementation.

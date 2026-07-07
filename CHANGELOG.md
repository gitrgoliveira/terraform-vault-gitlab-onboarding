# Changelog

All notable changes to this project are documented in this file.

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

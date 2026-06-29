output "bound_audiences" {
  description = "Echo of bound audiences for downstream principal module role binding."
  value       = var.bound_audiences
}

output "gitlab_instance" {
  description = "Echo of gitlab_instance input."
  value       = var.gitlab_instance
}

output "jwt_auth_path" {
  description = "JWT auth backend path for this GitLab trust mount."
  value       = vault_jwt_auth_backend.this.path
}

output "jwt_mount_accessor" {
  description = "JWT auth mount accessor for identity alias creation in principal modules."
  value       = vault_jwt_auth_backend.this.accessor
}

output "vault_address" {
  description = "Echo of render-only vault_address."
  value       = var.vault_address
}

output "vault_namespace" {
  description = "Echo of render-only vault_namespace."
  value       = var.vault_namespace
}

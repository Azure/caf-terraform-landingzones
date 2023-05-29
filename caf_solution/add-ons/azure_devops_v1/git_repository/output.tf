output "id" {
  value       = azuredevops_git_repository.git.id
  description = "The ID of the Git repository."
}
output "default_branch" {
  value = azuredevops_git_repository.git.default_branch
}
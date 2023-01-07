output "id" {
  value = github_repository.repository.repo_id
}

output "owner" {
  value = split("/", github_repository.repository.full_name).0
}

output "name" {
  value = github_repository.repository.name
}

output "full_name" {
  value = github_repository.repository.full_name
}

output "url" {
  value = github_repository.repository.html_url
}

output "clone_url" {
  value = github_repository.repository.http_clone_url
}

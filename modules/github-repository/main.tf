resource "github_repository" "repository" {
  name        = var.name
  description = var.description

  visibility = var.is_private ? "private" : "public"

  has_issues   = var.has_issues
  has_projects = var.has_projects
  has_wiki     = false

  delete_branch_on_merge = true
}

resource "github_repository" "repository" {
  name        = var.name
  description = var.description

  homepage_url = var.homepage_url

  visibility = var.is_private ? "private" : "public"

  has_issues   = var.has_issues
  has_projects = var.has_projects
  has_wiki     = false

  auto_init = var.auto_init

  delete_branch_on_merge = true

  security_and_analysis {
    advanced_security {
      status = var.is_private ? var.advanced_security : "enabled"
    }
    secret_scanning {
      status = "disabled"
    }
    secret_scanning_push_protection {
      status = "disabled"
    }
  }
}

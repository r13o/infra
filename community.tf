module "community_repository" {
  source      = "./modules/github-repository"
  name        = ".github"
  description = "Default community health files for the @${var.gh_owner} organization"
}

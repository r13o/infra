resource "cloudflare_zone" "hyperfetch" {
  account_id = local.cf_account_id
  zone       = "hyperfetch.net"
  plan       = "free"
}

resource "cloudflare_zone_settings_override" "hyperfetch" {
  zone_id = cloudflare_zone.hyperfetch.id
  settings {
    always_use_https         = "off"
    automatic_https_rewrites = "off"
  }
}

module "hyperfetch_repository" {
  source = "./modules/github-repository"
  name   = "hyperfetch"
}

resource "cloudflare_pages_project" "hyperfetch" {
  account_id        = local.cf_account_id
  name              = "hyperfetch"
  production_branch = "main"
  source {
    type = "github"
    config {
      owner             = module.hyperfetch_repository.owner
      repo_name         = module.hyperfetch_repository.name
      production_branch = "main"
    }
  }
}

resource "cloudflare_record" "hyperfetch" {
  zone_id = cloudflare_zone.hyperfetch.id
  name    = "@"
  type    = "CNAME"
  value   = cloudflare_pages_project.hyperfetch.subdomain
  proxied = true
}

resource "cloudflare_pages_domain" "hyperfetch" {
  account_id   = local.cf_account_id
  project_name = cloudflare_pages_project.hyperfetch.name
  domain       = cloudflare_record.hyperfetch.hostname
}

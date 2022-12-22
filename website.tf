module "website" {
  source       = "./modules/github-repository"
  name         = "website"
  description  = "Source code for the r13o.com website"
  homepage_url = "https://r13o.com"
}

data "cloudflare_accounts" "personal" {
  name = "Romuald's Account"
}

resource "cloudflare_pages_project" "website" {
  account_id        = local.cf_account_id
  name              = "r13o"
  production_branch = "main"
  source {
    type = "github"
    config {
      owner             = var.gh_owner
      repo_name         = module.website.name
      production_branch = "main"
    }
  }
}

resource "cloudflare_record" "root" {
  zone_id = cloudflare_zone.short.id
  name    = "@"
  type    = "CNAME"
  value   = cloudflare_pages_project.website.subdomain
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.short.id
  name    = "www"
  type    = "CNAME"
  value   = cloudflare_record.root.hostname
  proxied = true
}

resource "cloudflare_pages_domain" "short" {
  account_id   = local.cf_account_id
  project_name = cloudflare_pages_project.website.name
  domain       = cloudflare_record.root.hostname
}

resource "cloudflare_pages_domain" "short_www" {
  account_id   = local.cf_account_id
  project_name = cloudflare_pages_project.website.name
  domain       = cloudflare_record.www.hostname
}

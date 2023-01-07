module "website_repository" {
  source       = "./modules/github-repository"
  name         = "website"
  description  = "Source code for the r13o.com website"
  homepage_url = "https://r13o.com"
}

resource "cloudflare_pages_project" "website" {
  account_id        = local.cf_account_id
  name              = "r13o"
  production_branch = "main"
  build_config {
    destination_dir = "public"
  }
  source {
    type = "github"
    config {
      owner             = module.website_repository.owner
      repo_name         = module.website_repository.name
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
  type    = "A"
  value   = "192.0.2.1"
  proxied = true
}

resource "cloudflare_page_rule" "redirect_www" {
  zone_id = cloudflare_zone.short.id
  target  = "${cloudflare_record.www.hostname}/*"
  actions {
    forwarding_url {
      url         = "https://${cloudflare_record.root.hostname}/$1"
      status_code = 301
    }
  }
}

resource "cloudflare_pages_domain" "short" {
  account_id   = local.cf_account_id
  project_name = cloudflare_pages_project.website.name
  domain       = cloudflare_record.root.hostname
}

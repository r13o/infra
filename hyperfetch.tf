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
  source      = "./modules/github-repository"
  name        = "hyperfetch"
  description = "Just type hyperfetch.net/ in front of any URL to fetch"
}

resource "cloudflare_record" "hyperfetch" {
  zone_id = cloudflare_zone.hyperfetch.id
  name    = "@"
  type    = "A"
  value   = "192.0.2.1"
  proxied = true
}

resource "cloudflare_record" "hyperfetch_www" {
  zone_id = cloudflare_zone.hyperfetch.id
  name    = "www"
  type    = "CNAME"
  value   = cloudflare_record.hyperfetch.hostname
  proxied = true
}

resource "cloudflare_page_rule" "redirect_hyperfetch_www" {
  zone_id = cloudflare_zone.hyperfetch.id
  target  = "${cloudflare_record.hyperfetch_www.hostname}/*"
  actions {
    forwarding_url {
      url         = "http://${cloudflare_record.hyperfetch.hostname}/$1"
      status_code = 301
    }
  }
}

resource "cloudflare_pages_project" "hyperfetch" {
  account_id        = local.cf_account_id
  name              = "hyperfetch"
  production_branch = "main"
}

resource "cloudflare_record" "hyperfetch_howto" {
  zone_id = cloudflare_zone.hyperfetch.id
  name    = "howto"
  type    = "CNAME"
  value   = cloudflare_pages_project.hyperfetch.subdomain
  proxied = true
}

resource "cloudflare_pages_domain" "hyperfetch" {
  account_id   = local.cf_account_id
  project_name = cloudflare_pages_project.hyperfetch.name
  domain       = cloudflare_record.hyperfetch_howto.hostname
}

resource "github_actions_secret" "cf_token" {
  repository      = module.hyperfetch_repository.name
  secret_name     = "CF_API_TOKEN"
  plaintext_value = var.gh_secret_cf_token
}

resource "github_actions_secret" "cf_account_id" {
  repository      = module.hyperfetch_repository.name
  secret_name     = "CF_ACCOUNT_ID"
  plaintext_value = local.cf_account_id
}

resource "cloudflare_worker_route" "hyperfetch" {
  zone_id     = cloudflare_zone.hyperfetch.id
  pattern     = "${cloudflare_record.hyperfetch.hostname}/*"
  script_name = "hyperfetch"
}

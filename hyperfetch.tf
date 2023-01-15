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

resource "cloudflare_record" "hyperfetch" {
  zone_id = cloudflare_zone.hyperfetch.id
  name    = "@"
  type    = "CNAME"
  value   = "r13o.github.io"
  proxied = true
}

resource "github_actions_secret" "cf_token" {
  repository       = module.hyperfetch_repository.name
  secret_name      = "CF_API_TOKEN"
  plaintext_value  = var.gh_secret_cf_token
}

resource "github_actions_secret" "cf_account_id" {
  repository       = module.hyperfetch_repository.name
  secret_name      = "CF_ACCOUNT_ID"
  plaintext_value  = local.cf_account_id
}

resource "cloudflare_worker_route" "hyperfetch" {
  zone_id     = cloudflare_zone.hyperfetch.id
  pattern     = "${cloudflare_record.hyperfetch.hostname}/http*"
  script_name = "hyperfetch"
}

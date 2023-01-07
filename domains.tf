resource "cloudflare_zone" "short" {
  account_id = local.cf_account_id
  zone       = "r13o.com"
}

resource "cloudflare_zone_settings_override" "short" {
  zone_id = cloudflare_zone.short.id
  settings {
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    minify {
      css  = "on"
      js   = "on"
      html = "on"
    }
  }
}

module "alias" {
  source       = "./modules/cloudflare-alias"
  account_id   = local.cf_account_id
  domain_name  = "romualdbulyshko.com"
  redirect_url = "https://${cloudflare_record.root.hostname}/?ref=romualdbulyshko.com"
}

resource "cloudflare_zone" "short" {
  zone = "r13o.com"
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
  domain_name  = "romualdbulyshko.com"
  redirect_url = "https://${cloudflare_record.root.hostname}/?ref=romualdbulyshko.com"
}

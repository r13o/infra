resource "cloudflare_zone" "alias" {
  account_id = var.account_id
  zone       = var.domain_name
}

resource "cloudflare_record" "root" {
  zone_id = cloudflare_zone.alias.id
  name    = "@"
  type    = "A"
  value   = "192.0.2.1"
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.alias.id
  name    = "www"
  type    = "CNAME"
  value   = cloudflare_record.root.hostname
  proxied = true
}

resource "cloudflare_page_rule" "redirect" {
  zone_id = cloudflare_zone.alias.id
  target  = "*${cloudflare_record.root.hostname}/*"

  actions {
    forwarding_url {
      url         = var.redirect_url
      status_code = 301
    }
  }
}

provider "cloudflare" {
  api_token = var.cf_token
}

resource "cloudflare_zone" "domain" {
  zone = "r13o.com"
}

resource "cloudflare_record" "root" {
  zone_id = cloudflare_zone.domain.id
  name    = "@"
  type    = "CNAME"
  value   = "r13o.github.io"
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.domain.id
  name    = "www"
  type    = "CNAME"
  value   = "r13o.com"
}

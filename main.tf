provider "cloudflare" {
  api_token = var.cf_token
}

data "cloudflare_zones" "r13o" {
  filter {
    name   = "r13o.com"
    status = "active"
  }
}

resource "cloudflare_record" "r13o" {
  zone_id = data.cloudflare_zones.r13o.zones.0.id
  name    = "@"
  type    = "CNAME"
  value   = "r13o.github.io"
}

resource "cloudflare_record" "www_r13o" {
  zone_id = data.cloudflare_zones.r13o.zones.0.id
  name    = "www"
  type    = "CNAME"
  value   = "r13o.com"
}

resource "random_id" "tunnel_secret" {
  byte_length = var.secret_byte_length
}

resource "cloudflare_argo_tunnel" "tunnel" {
  account_id = var.account_id
  name       = var.name
  secret     = random_id.tunnel_secret.b64_std
}

resource "cloudflare_record" "tunnel" {
  name    = var.name
  type    = "CNAME"
  zone_id = var.zone_id
  value   = cloudflare_argo_tunnel.tunnel.cname
  proxied = true
}

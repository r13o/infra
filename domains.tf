resource "cloudflare_zone" "short" {
  zone = "r13o.com"
}

module "alias" {
  source       = "./modules/cloudflare-alias"
  domain_name  = "romualdbulyshko.com"
  redirect_url = "https://${cloudflare_record.root.hostname}/?ref=romualdbulyshko.com"
}

module "tunnels_repository" {
  source      = "./modules/github-repository"
  name        = "tunnels"
  description = "This repository contains credentials for Cloudflare Tunnels"
  is_private  = true
  auto_init   = true
}

module "tunnels" {
  for_each   = toset(var.cf_tunnels)
  source     = "./modules/cloudflare-tunnel"
  account_id = local.cf_account_id
  zone_id    = cloudflare_zone.short.id
  name       = each.value
}

resource "github_repository_file" "tunnel_credentials" {
  for_each            = module.tunnels
  repository          = module.tunnels_repository.name
  branch              = "main"
  file                = "${each.value.hostname}.json"
  content             = each.value.credentials
  commit_message      = "Managed by Terraform"
  overwrite_on_create = true
}

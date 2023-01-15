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
  depends_on = [
    digitalocean_app.hyperfetch
  ]

  zone_id = cloudflare_zone.hyperfetch.id
  name    = "@"
  type    = "CNAME"
  value   = split("://", digitalocean_app.hyperfetch.default_ingress).1
  proxied = true
}

resource "cloudflare_record" "hyperfetch_www" {
  zone_id = cloudflare_zone.hyperfetch.id
  name    = "www"
  type    = "A"
  value   = "192.0.2.1"
  proxied = true
}

resource "cloudflare_page_rule" "redirect_hyperfetch_www" {
  zone_id = cloudflare_zone.short.id
  target  = "${cloudflare_record.www.hostname}/*"
  actions {
    forwarding_url {
      url         = "http://${cloudflare_record.root.hostname}/$1"
      status_code = 301
    }
  }
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
  pattern     = "${cloudflare_record.hyperfetch.hostname}/http*"
  script_name = "hyperfetch"
}

resource "digitalocean_app" "hyperfetch" {
  spec {
    name   = "hyperfetch"
    region = "fra"

    domain {
      name = cloudflare_zone.hyperfetch.zone
      type = "PRIMARY"
    }

    static_site {
      name          = "website"
      build_command = "curl -fsSL https://deno.land/x/install/install.sh | sh && ~/.deno/bin/deno task build"
      output_dir    = "_site"

      github {
        branch         = "main"
        deploy_on_push = true
        repo           = module.hyperfetch_repository.full_name
      }
    }
  }
}
provider "cloudflare" {
  api_token = var.cf_token
}

provider "github" {
  token = var.gh_token
  owner = var.gh_owner
}

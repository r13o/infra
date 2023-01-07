data "cloudflare_accounts" "personal" {
  name = var.cf_account_name
}

locals {
  cf_account_id = data.cloudflare_accounts.personal.accounts.0.id
}

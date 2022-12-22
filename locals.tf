locals {
  cf_account_id = data.cloudflare_accounts.personal.accounts.0.id
}
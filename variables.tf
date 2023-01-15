variable "cf_token" {
  type        = string
  description = "Cloudflare API Token"
  sensitive   = true
}

variable "cf_account_name" {
  type        = string
  description = "Cloudflare account name"
  default     = "Romuald's Account"
}

variable "cf_tunnels" {
  type        = list(string)
  description = "List of Cloudflare Tunnels"
  default = [
    "bot",
  ]
}

variable "gh_token" {
  type        = string
  description = "GitHub personal access token"
  sensitive   = true
}

variable "gh_owner" {
  type        = string
  description = "GitHub organization or individual user account"
  default     = "r13o"
}

variable "gh_secret_cf_token" {
  type        = string
  description = "Cloudflare API Token for GitHub Actions"
  sensitive   = true
}
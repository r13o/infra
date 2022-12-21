variable "cf_token" {
  type        = string
  description = "Cloudflare API Token"
  sensitive   = true
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

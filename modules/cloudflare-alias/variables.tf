variable "account_id" {
  type        = string
  description = "Cloudflare account ID"
  default     = ""
}

variable "domain_name" {
  type = string
}

variable "redirect_url" {
  type = string
}

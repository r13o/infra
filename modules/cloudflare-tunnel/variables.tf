variable "zone_id" {
  type        = string
  description = "Cloudflare zone ID"
}

variable "account_id" {
  type        = string
  description = "Cloudflare account ID"
}

variable "secret_byte_length" {
  type        = number
  description = "The number of random bytes to produce for the secret"
  default     = 40
}

variable "name" {
  type        = string
  description = "Cloudflare tunnel name"
}

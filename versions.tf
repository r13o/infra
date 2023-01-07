terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.31.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.13.0"
    }
  }
  required_version = ">= 1.1.0"
}

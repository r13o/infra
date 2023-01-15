terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.31.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.25.2"
    }
    github = {
      source  = "integrations/github"
      version = "5.13.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
  required_version = ">= 1.1.0"
}

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 5.13.0"
    }
  }
  required_version = ">= 1.1.0"
}

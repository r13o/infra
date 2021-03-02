terraform {
  backend "remote" {
    organization = "r13o"

    workspaces {
      name = "infra"
    }
  }
}

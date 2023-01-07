variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = ""
}

variable "homepage_url" {
  type    = string
  default = ""
}

variable "is_private" {
  type    = bool
  default = false
}

variable "has_issues" {
  type    = bool
  default = true
}

variable "has_projects" {
  type    = bool
  default = false
}

variable "auto_init" {
  type    = bool
  default = false
}
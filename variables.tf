variable "private_repositories" {
  type = map(object({
    image_tag_mutability = optional(string)
    pull_accounts        = optional(list(string))
    push_accounts        = optional(list(string))
  }))
  description = "List of private repositories that should be created"
  default     = {}
}

variable "public_repositories" {
  type = map(object({
    about             = optional(string)
    architectures     = optional(list(string))
    description       = optional(string)
    logo_image_blob   = optional(string)
    operating_systems = optional(list(string))
    usage_text        = optional(string)
    push_accounts     = optional(list(string))
  }))
  description = "List of public repositories that should be created"
  default     = {}
}

variable "global_pull_accounts" {
  type        = list(string)
  description = "List of accounts that can pull from all the private repositories"
  default     = []
}

variable "global_push_accounts" {
  type        = list(string)
  description = "List of accounts that can push to all the repositories"
  default     = []
}

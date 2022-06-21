variable "config" {
  type = object({
    repositories = map(object({
      image_tag_mutability = optional(string)
      pull_accounts        = optional(list(string))
      push_accounts        = optional(list(string))
    }))
    global_pull_accounts = optional(list(string))
    global_push_accounts = optional(list(string))
  })
}
locals {
  config = var.config

  repo_pull_account_arns = { for k, repo in local.config.repositories : k => repo.pull_accounts != null ? [
    for ak, ac in repo.pull_accounts : "arn:aws:iam::${ac}:root"
  ] : [] }
  repo_push_account_arns = { for k, repo in local.config.repositories : k => repo.push_accounts != null ? [
    for ak, ac in repo.push_accounts : "arn:aws:iam::${ac}:root"
  ] : [] }

  global_pull_account_arns = concat([for ac in local.config.global_pull_accounts : "arn:aws:iam::${ac}:root"], ["arn:aws:iam::${local.account_id}:root"])
  global_push_account_arns = concat([for ac in local.config.global_push_accounts : "arn:aws:iam::${ac}:root"], ["arn:aws:iam::${local.account_id}:root"])
}
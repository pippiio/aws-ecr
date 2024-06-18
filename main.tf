locals {
  repo_pull_account_arns = { for k, repo in var.private_repositories : k => repo.pull_accounts != null ? [
    for ak, ac in repo.pull_accounts : "arn:aws:iam::${ac}:root"
  ] : [] }
  repo_push_account_arns = { for k, repo in var.private_repositories : k => repo.push_accounts != null ? [
    for ak, ac in repo.push_accounts : "arn:aws:iam::${ac}:root"
  ] : [] }

  public_repo_push_account_arns = { for k, repo in var.public_repositories : k => repo.push_accounts != null ? [
    for ak, ac in repo.push_accounts : "arn:aws:iam::${ac}:root"
  ] : [] }

  global_pull_account_arns = concat([for ac in var.global_pull_accounts : "arn:aws:iam::${ac}:root"], ["arn:aws:iam::${local.account_id}:root"])
  global_push_account_arns = concat([for ac in var.global_push_accounts : "arn:aws:iam::${ac}:root"], ["arn:aws:iam::${local.account_id}:root"])
}

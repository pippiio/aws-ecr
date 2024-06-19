locals {
  private_repo_pull_arns = { for k, repo in var.private_repositories : k => concat(
    [for index, account in repo.pull_accounts : "arn:aws:iam::${account}:root"],
    [for index, role in repo.pull_role_arns : role]
  ) }

  private_repo_push_arns = { for k, repo in var.private_repositories : k => concat(
    [for index, account in repo.push_accounts : "arn:aws:iam::${account}:root"],
    [for index, role in repo.push_role_arns : role]
  ) }

  public_repo_push_arns = { for k, repo in var.public_repositories : k => concat(
    [for index, account in repo.push_accounts : "arn:aws:iam::${account}:root"],
    [for index, role in repo.push_role_arns : role]
  ) }

  global_pull_account_arns = concat([for ac in var.global_pull_accounts : "arn:aws:iam::${ac}:root"], ["arn:aws:iam::${local.account_id}:root"])
  global_push_account_arns = concat([for ac in var.global_push_accounts : "arn:aws:iam::${ac}:root"], ["arn:aws:iam::${local.account_id}:root"])

  create_iam_users = toset([for k, repo in merge(var.private_repositories, var.public_repositories) : k if repo.create_iam_user])
}

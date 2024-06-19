# kics-scan ignore-block
resource "aws_iam_user" "artifact_user" {
  for_each = local.create_iam_users

  name = "${local.name_prefix}${each.key}"
  path = "/artifact/"

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}${each.key}"
  })
}

resource "aws_iam_access_key" "artifact_user" {
  for_each = aws_iam_user.artifact_user

  user = each.value.name
}

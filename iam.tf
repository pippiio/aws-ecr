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

# kics-scan ignore-block
resource "aws_iam_user_policy" "artifact_user" {
  for_each = aws_iam_user.artifact_user

  name   = "ECR"
  user   = each.value.name
  policy = data.aws_iam_policy_document.artifact_user[each.key].json
}

data "aws_iam_policy_document" "artifact_user" {
  for_each = aws_iam_user.artifact_user

  statement {
    sid       = "AllowECR"
    actions   = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    resources = compact([
      try(aws_ecr_repository.this[each.key].arn, null),
      try(aws_ecrpublic_repository.this[each.key].arn, null),
    ])
  }
}

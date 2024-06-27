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
  policy = try(data.aws_iam_policy_document.artifact_user_private[each.key].json, data.aws_iam_policy_document.artifact_user_public[each.key].json)
}

data "aws_iam_policy_document" "artifact_user_private" {
  for_each = aws_ecr_repository.this

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
    resources = [
      each.value.arn
    ]
  }

  statement {
    sid       = "AllowECRAuthorization" # needed to login to ecr
    actions   = [
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "artifact_user_public" {
  for_each = aws_ecrpublic_repository.this

  statement {
    sid       = "AllowECRPublic"
    actions   = [
      "ecr-public:BatchCheckLayerAvailability",
      "ecr-public:BatchGetImage",
      "ecr-public:CompleteLayerUpload",
      "ecr-public:GetDownloadUrlForLayer",
      "ecr-public:InitiateLayerUpload",
      "ecr-public:PutImage",
      "ecr-public:UploadLayerPart",
    ]
    resources = [
      each.value.arn
    ]
  }

  statement {
    sid       = "AllowECRPublicAuthorization" # needed to login to ecr
    actions   = [
      "ecr-public:GetAuthorizationToken",
      "sts:GetServiceBearerToken"
    ]
    resources = ["*"]
  }
}

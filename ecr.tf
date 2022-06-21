resource "aws_ecr_repository" "this" {
  for_each = local.config.repositories

  name                 = "${local.name_prefix}${each.key}"
  image_tag_mutability = each.value.image_tag_mutability != null ? each.value.image_tag_mutability : "MUTABLE"

  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.ecr.arn
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}${each.key}"
  })
}

resource "aws_ecr_repository_policy" "this" {
  for_each = aws_ecr_repository.this

  repository = each.value.name
  policy     = data.aws_iam_policy_document.repository[each.key].json
}
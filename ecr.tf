# kics-scan ignore-block
resource "aws_ecr_repository" "this" {
  for_each = var.private_repositories

  name                 = "${local.name_prefix}${each.key}"
  image_tag_mutability = each.value.image_tag_mutability != null ? each.value.image_tag_mutability : "MUTABLE"

  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.ecr["private"].arn
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}${each.key}"
  })
}

resource "aws_ecr_repository_policy" "private" {
  for_each = aws_ecr_repository.this

  repository = each.value.name
  policy     = data.aws_iam_policy_document.private[each.key].json
}

resource "aws_ecrpublic_repository" "this" {
  for_each = var.public_repositories

  repository_name = each.key

  catalog_data {
    about_text        = each.value.about
    architectures     = each.value.architectures
    description       = each.value.description
    logo_image_blob   = each.value.logo_image_blob
    operating_systems = each.value.operating_systems
    usage_text        = each.value.usage_text
  }

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}${each.key}"
  })
}

resource "aws_ecr_repository_policy" "public" {
  for_each = aws_ecrpublic_repository.this

  repository = each.value.repository_name
  policy     = data.aws_iam_policy_document.public[each.key].json
}

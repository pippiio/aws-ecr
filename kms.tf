data "aws_iam_policy_document" "kms" {
  for_each = length(var.private_repositories) > 0 ? toset(["private"]) : []

  statement {
    resources = ["*"]
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.id}:root"]
    }
  }
}

# kics-scan ignore-block
resource "aws_kms_key" "ecr" {
  for_each = data.aws_iam_policy_document.kms

  description         = "KMS CMK used by ecr"
  enable_key_rotation = true
  policy              = each.value.json

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}ecr-kms"
  })
}

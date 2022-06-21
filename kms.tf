data "aws_iam_policy_document" "kms" {
  statement {
    resources = ["*"]
    actions   = ["kms:*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.id}:root"]
    }
  }
}

resource "aws_kms_key" "ecr" {
  description         = "KMS CMK used by ecr"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.kms.json

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}ecr-kms"
  })
}

resource "random_pet" "ecr" {
}

resource "aws_kms_alias" "ecr" {
  name          = "alias/ecr-kms-cmk-${random_pet.ecr.id}"
  target_key_id = aws_kms_key.ecr.key_id
}

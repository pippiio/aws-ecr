// Create Contributer User in Config
resource "aws_iam_user" "this" {
  name = "${local.name_prefix}ecr"

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}ecr"
  })
}

// Create Assumeable roles in stage/prod
data "aws_iam_policy_document" "this" {
  statement {
    sid = "AllowPushPull"
    actions = [
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    principals {
      type = "AWS"
      identifiers = [
        aws_iam_user.this.arn
      ]
    }
  }
}

resource "aws_iam_user_policy" "this" {
  name = "${local.name_prefix}ecr-policy"
  user = aws_iam_user.this.name

  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}
output "access_key" {
  value = aws_iam_access_key.this.id
}
output "secret" {
  value     = aws_iam_access_key.this.secret
  sensitive = true
}

data "aws_iam_policy_document" "private" {
  for_each = var.private_repositories

  statement {
    sid = "PullPolicy"

    principals {
      type        = "AWS"
      identifiers = sort(concat(local.global_pull_account_arns, local.repo_pull_account_arns[each.key]))
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImageScanFindings",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:ListTagsForResource",
    ]
  }

  statement {
    sid = "PushPolicy"

    principals {
      type        = "AWS"
      identifiers = sort(concat(local.global_push_account_arns, local.repo_push_account_arns[each.key]))
    }

    actions = [
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
  }
}

data "aws_iam_policy_document" "public" {
  for_each = var.public_repositories

  statement {
    sid = "PushPolicy"

    principals {
      type        = "AWS"
      identifiers = sort(concat(local.global_push_account_arns, local.public_repo_push_account_arns[each.key]))
    }

    actions = [
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
  }
}

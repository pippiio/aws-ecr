data "aws_iam_policy_document" "repository" {
  for_each = local.config.repositories

  statement {
    sid = "PullPolicy"

    principals {
      type        = "AWS"
      identifiers = concat(local.global_pull_account_arns, local.repo_pull_account_arns[each.key])
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
      identifiers = concat(local.global_push_account_arns, local.repo_push_account_arns[each.key])
    }

    actions = [
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
  }
}
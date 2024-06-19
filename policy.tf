data "aws_iam_policy_document" "private" {
  for_each = var.private_repositories

  statement {
    sid = "PullPolicy"

    principals {
      type        = "AWS"
      identifiers = sort(concat(concat(local.global_pull_account_arns, local.private_repo_pull_arns[each.key]), try([aws_iam_user.artifact_user[each.key].arn], [])))
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
      identifiers = sort(concat(concat(local.global_push_account_arns, local.private_repo_push_arns[each.key]), try([aws_iam_user.artifact_user[each.key].arn], [])))
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
      identifiers = sort(concat(concat(local.global_push_account_arns, local.public_repo_push_arns[each.key]), try([aws_iam_user.artifact_user[each.key].arn], [])))
    }

    actions = [
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
  }
}

output "private_repositories" {
  value       = aws_ecr_repository.this
  description = "List of private ECR repositories"
}

output "public_repositories" {
  value       = aws_ecrpublic_repository.this
  description = "List of public ECR repositories"
}

output "iam_users" {
  value = {
    for key, user in aws_iam_user.artifact_user :
    user.name => {
      user_arn          = user.arn
      access_key_id     = aws_iam_access_key.artifact_user[key].id
      secret_access_key = aws_iam_access_key.artifact_user[key].secret
    }
  }
  sensitive   = true
  description = "List of IAM users"
}

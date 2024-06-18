output "private_repositories" {
  value = aws_ecr_repository.this
  description = "List of private ECR repositories"
}

output "public_repositories" {
  value = aws_ecrpublic_repository.this
  description = "List of public ECR repositories"
}

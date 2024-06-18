# aws-ecr
The aws-ecr is a generic Terraform module within the pippi.io family, maintained by Tech Chapter. The pippi.io modules are build to support common use cases often seen at Tech Chapters clients. They are created with best practices in mind and battle tested at scale. All modules are free and open-source under the Mozilla Public License Version 2.0.

The aws-ecr module is made to deploying AWS ECR resources on amazon.

## Usage
```hcl
module "ecr" {
  source = "github.com/pippiio/aws-ecr.git"

  global_pull_accounts = ["123456789"]
  global_push_accounts = ["987654321"]

  private_repositories = {
    "app" = {
      pull_accounts = ["657453672"]
    },
    "app2" = {
      pull_accounts = ["657453672"]
    }
  }

  public_repositories = {
    "app3" = {
      push_accounts = ["657453672"]

      about             = "App3 about"
      architectures     = ["ARM"]
      description       = "App3 description"
      logo_image_blob   = filebase64("img.png")
      operating_systems = ["Linux"]
      usage_text        = "pull"
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_ecrpublic_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecrpublic_repository) | resource |
| [aws_kms_key.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | A map of default tags, that will be applied to all resources applicable. | `map(string)` | `{}` | no |
| <a name="input_global_pull_accounts"></a> [global\_pull\_accounts](#input\_global\_pull\_accounts) | List of accounts that can pull from all the private repositories | `list(string)` | `[]` | no |
| <a name="input_global_push_accounts"></a> [global\_push\_accounts](#input\_global\_push\_accounts) | List of accounts that can push to all the repositories | `list(string)` | `[]` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | A prefix that will be used on all named resources. | `string` | `"pippi-"` | no |
| <a name="input_private_repositories"></a> [private\_repositories](#input\_private\_repositories) | List of private repositories that should be created | <pre>map(object({<br>    image_tag_mutability = optional(string)<br>    pull_accounts        = optional(list(string))<br>    push_accounts        = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_public_repositories"></a> [public\_repositories](#input\_public\_repositories) | List of public repositories that should be created | <pre>map(object({<br>    about             = optional(string)<br>    architectures     = optional(list(string))<br>    description       = optional(string)<br>    logo_image_blob   = optional(string)<br>    operating_systems = optional(list(string))<br>    usage_text        = optional(string)<br>    push_accounts     = optional(list(string))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_repositories"></a> [private\_repositories](#output\_private\_repositories) | List of private ECR repositories |
| <a name="output_public_repositories"></a> [public\_repositories](#output\_public\_repositories) | List of public ECR repositories |
<!-- END_TF_DOCS -->

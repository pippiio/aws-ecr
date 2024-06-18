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
<!-- END_TF_DOCS -->

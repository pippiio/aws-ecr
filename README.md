# pippiio aws-ecr
Terraform module for deploying AWS ECR resources

## Usage
```hcl
module "ecr" {
  source = "github.com/pippiio/aws-ecr.git"

  config = {
    global_pull_accounts = ["123456789"]
    global_push_accounts = ["987654321"]
    repositories = {
      "app" = {
        pull_accounts = ["657453672"]
      },
      "app2" = {
        pull_accounts = ["657453672"]
      }
    }
  }
}
```

## Requirements
|Name     |Version |
|---------|--------|
|terraform|>= 1.2.0|
|aws      |~> 4.0  |


## Variables
### config:
|Name                |Type          |Default        |Required|Description|
|--------------------|--------------|---------------|--------|-----------|
|repositories        |map(object({})|nil            |yes     |Repositories to be created|
|global_pull_accounts|list(string)  |current account|no      |Global accounts for pulling of ecr|
|global_push_accounts|list(string)  |current account|no      |Global accoutns for pushing of ecr|

### name_prefix:
|Type        |Default|Required|Description|
|------------|-------|--------|-----------|
|string      |pippi- |no      |A prefix that will be used on all named resources|

### default_tags:
|Type        |Default|Required|Description|
|------------|-------|--------|-----------|
|map(string) |nil    |no      |A map of default tags, that will be applied to all resources applicable|

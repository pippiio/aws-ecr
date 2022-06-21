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
<table>
<thead>
<tr>
<th>Name</th>
<th>Type</th>
<th>Default</th>
<th>Required</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>repositories<br></td>
<td>

```hcl
map(object({
  image_tag_mutability = optional(string)
  pull_accounts        = optional(list(string))
  push_accounts        = optional(list(string))
}))
```
</td>
<td>nil</td>
<td>yes</td>
<td>Repositories to be created</td>
</tr>
<tr>
<td>global_pull_accounts</td>
<td>

```hcl
list(string)
```
</td>
<td>current account</td>
<td>no</td>
<td>Global accounts for pulling from ecr</td>
</tr>
<tr>
<td>global_push_accounts</td>
<td>

```hcl
list(string)
```
</td>
<td>current account</td>
<td>no</td>
<td>Global accounts for pushing to ecr</td>
</tr>
</tbody>
</table>

### name_prefix:
|Type        |Default|Required|Description|
|------------|-------|--------|-----------|
|string      |pippi- |no      |A prefix that will be used on all named resources|

### default_tags:
|Type        |Default|Required|Description|
|------------|-------|--------|-----------|
|map(string) |nil    |no      |A map of default tags, that will be applied to all resources applicable|

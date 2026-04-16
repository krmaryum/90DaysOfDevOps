# Terraform Plan Command

## What is `terraform plan`?

`terraform plan` shows what Terraform is going to do before making any
changes.

------------------------------------------------------------------------

## Simple Explanation

It answers the question:

> "If I run apply, what exactly will happen?"

------------------------------------------------------------------------

## What it does

-   Compares your `.tf` configuration with current infrastructure state\
-   Shows what will be created, updated, or destroyed

------------------------------------------------------------------------

## Symbols Meaning

  Symbol   Meaning
  -------- ----------------------------
  `+`      Resource will be created
  `~`      Resource will be modified
  `-`      Resource will be destroyed

------------------------------------------------------------------------

## Example

Running:

``` bash
terraform plan
```

Example output:

    + create aws_instance.my_instance
    ~ update aws_s3_bucket.my_bucket
    - destroy aws_security_group.old_sg

------------------------------------------------------------------------

## What it does NOT do

-   Does not create resources\
-   Does not change anything\
-   Only shows a preview

------------------------------------------------------------------------

## Why it is useful

-   Prevents mistakes\
-   Allows review before changes\
-   Helps debugging\
-   Safe preview

------------------------------------------------------------------------

## Workflow

``` bash
terraform init
terraform validate
terraform plan
terraform apply
```

------------------------------------------------------------------------

## Advanced Usage

### Save plan

``` bash
terraform plan -out=plan.tfplan
```

### Apply saved plan

``` bash
terraform apply plan.tfplan
```

------------------------------------------------------------------------

## Key Takeaway

-   `terraform plan` = preview changes\
-   `terraform apply` = execute changes

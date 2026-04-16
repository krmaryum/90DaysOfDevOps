# Terraform Apply Command

## What is `terraform apply`?

`terraform apply` is the command that creates, updates, or deletes
infrastructure based on your Terraform configuration.

------------------------------------------------------------------------

## Simple Explanation

It answers the question:

> "Execute the changes defined in my Terraform code"

------------------------------------------------------------------------

## What it does

-   Reads all `.tf` files in the directory\
-   Compares configuration with current state\
-   Shows execution plan\
-   Asks for confirmation\
-   Applies changes to real infrastructure

------------------------------------------------------------------------

## Example

Running:

``` bash
terraform apply
```

Output:

    Plan: 2 to add, 0 to change, 0 to destroy.

After confirmation:

    Apply complete! Resources: 2 added.

------------------------------------------------------------------------

## What it does NOT do

-   Does not work on a single file\
-   Does not ignore other `.tf` files in the folder

------------------------------------------------------------------------

## Can we apply a specific file?

❌ No, Terraform does not support applying a single `.tf` file.

------------------------------------------------------------------------

## Why?

Terraform works at the directory level and automatically loads all `.tf`
files.

------------------------------------------------------------------------

## Alternative Options

### Apply specific resource

``` bash
terraform apply -target=aws_instance.my_instance
```

------------------------------------------------------------------------

### Use separate folders

Organize resources into different directories:

    ec2-project/
    s3-project/

------------------------------------------------------------------------

## Workflow

``` bash
terraform init
terraform validate
terraform plan
terraform apply
```

------------------------------------------------------------------------

## Key Takeaway

-   `terraform apply` = execute infrastructure changes\
-   Works on full directory, not individual files\
-   Use `-target` for specific resources

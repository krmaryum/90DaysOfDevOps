# Terraform Validate Command

## What is `terraform validate`?

`terraform validate` is a command that checks your Terraform
configuration for errors before execution.

------------------------------------------------------------------------

## What it checks

-   Syntax correctness of `.tf` files\
-   Required arguments are present\
-   Resource references are valid\
-   Configuration follows Terraform structure

------------------------------------------------------------------------

## What it does NOT do

-   Does not connect to AWS or any provider\
-   Does not create or modify resources\
-   Does not verify AMI IDs or resource availability\
-   Does not check if S3 bucket names are unique

------------------------------------------------------------------------

## Simple Explanation

It answers the question:

> "Is my Terraform code written correctly?"

------------------------------------------------------------------------

## Example

### Incorrect Code

``` hcl
resource "local_file" "my_file" {
  filename = demo.txt
}
```

Running:

``` bash
terraform validate
```

Output:

    Error: Reference to undeclared resource

------------------------------------------------------------------------

### Correct Code

``` hcl
resource "local_file" "my_file" {
  filename = "demo.txt"
}
```

Running:

``` bash
terraform validate
```

Output:

    Success! The configuration is valid.

------------------------------------------------------------------------

## When to Use

Always run before planning:

``` bash
terraform init
terraform validate
terraform plan
terraform apply
```

------------------------------------------------------------------------

## Why it is useful

-   Catches errors early\
-   Saves time\
-   Prevents failed deployments\
-   Helps debugging

------------------------------------------------------------------------

## Key Takeaway

-   `terraform validate` checks code correctness\
-   `terraform plan` checks infrastructure changes

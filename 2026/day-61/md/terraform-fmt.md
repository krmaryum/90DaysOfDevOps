# Terraform Command Explanation

## terraform fmt

``` bash
terraform fmt   # Automatically formats Terraform code to standard style
```

### What it does

-   Fixes indentation\
-   Aligns arguments properly\
-   Makes `.tf` files clean and readable\
-   Ensures consistent formatting across team

------------------------------------------------------------------------

### Example

**Before:**

``` hcl
resource "aws_s3_bucket" "my_bucket" {
bucket="terraweek-khalid-2026"
tags={Name="Test"}
}
```

**After running `terraform fmt`:**

``` hcl
resource "aws_s3_bucket" "my_bucket" {
  bucket = "terraweek-khalid-2026"

  tags = {
    Name = "Test"
  }
}
```

------------------------------------------------------------------------

### Why it matters

-   Improves readability\
-   Avoids messy code in Git commits\
-   Follows Terraform best practices

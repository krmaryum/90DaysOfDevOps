# Terraform Quick Commands

## Command Table

  -----------------------------------------------------------------------------------------------
  Command                             Purpose                 Example
  ----------------------------------- ----------------------- -----------------------------------
  `terraform init`                    Initialize project,     `terraform init`
                                      download providers      

  `terraform validate`                Check syntax and        `terraform validate`
                                      configuration           

  `terraform fmt`                     Format Terraform files  `terraform fmt`

  `terraform plan`                    Show execution plan     `terraform plan`

  `terraform apply`                   Create/update           `terraform apply`
                                      infrastructure          

  `terraform destroy`                 Delete infrastructure   `terraform destroy`

  `terraform show`                    Show current state      `terraform show`

  `terraform state list`              List resources          `terraform state list`

  `terraform output`                  Show outputs            `terraform output`

  `terraform plan -destroy`           Preview destroy         `terraform plan -destroy`

  `terraform apply -auto-approve`     Apply without prompt    `terraform apply -auto-approve`

  `terraform destroy -auto-approve`   Destroy without prompt  `terraform destroy -auto-approve`
  -----------------------------------------------------------------------------------------------

------------------------------------------------------------------------

## Typical Workflow

``` bash
terraform init
terraform validate
terraform plan
terraform apply
```

------------------------------------------------------------------------

## Cleanup

``` bash
terraform destroy
```

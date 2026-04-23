# Terraform and SSH Errors with Solutions

## Project Context

This note summarizes the errors and fixes that came up after creating:

- `variables.tf`
- `ec2.tf`

The setup was used to create AWS EC2 instances with Terraform and then connect to them using SSH.

---

# 1. Error: Missing required provider

## Error message

```bash
Error: Missing required provider

This configuration requires provider registry.terraform.io/hashicorp/aws,
but that provider isn't available. You may be able to install it
automatically by running:
  terraform init
```

## Why it happened

Terraform configuration used AWS resources, but the AWS provider plugin had not been downloaded yet.

## Solution

Run:

```bash
terraform init
```

## Result

Terraform downloaded the AWS provider and initialized the working directory.

---

# 2. Error: Unsupported attribute `instance_type`

## Error message

```bash
Error: Unsupported attribute

on ec2.tf line 79, in resource "aws_instance" "my_instance":
79: instance_type = each.value.instance_type

each.value is object with 3 attributes

This object does not have an attribute named "instance_type".
```

## Why it happened

In `variables.tf`, the `instances` variable only contained:

- `ami`
- `user`
- `os_family`

But in `ec2.tf`, the code tried to use:

```hcl
each.value.instance_type
```

Since `instance_type` was not defined in the variable object, Terraform failed.

## Solution used

Replace:

```hcl
instance_type = each.value.instance_type
```

with:

```hcl
instance_type = "t3.micro"
```

## Alternative solution

Another valid option would be to add `instance_type` to the `variables.tf` object type and to every instance entry.

---

# 3. Confusion about `your-key.pem`

## Situation

The SSH command example used:

```bash
ssh -i your-key.pem ubuntu@PUBLIC_IP
```

But the actual project files contained:

```bash
terra-automate-key
terra-automate-key.pub
```

## Why it happened

The setup used a locally created SSH key pair, not a `.pem` file downloaded from AWS.

That means:

- `terra-automate-key` = private key
- `terra-automate-key.pub` = public key

## Solution

Use:

```bash
ssh -i terra-automate-key ubuntu@PUBLIC_IP
```

instead of:

```bash
ssh -i your-key.pem ubuntu@PUBLIC_IP
```

---

# 4. Error: Identity file not accessible

## Error message

```bash
Warning: Identity file terra-automate-key not accessible: No such file or directory.
```

## Why it happened

The SSH command was run from inside a remote EC2 instance, not from the local machine.

The file `terra-automate-key` existed only on the local machine, not inside the EC2 server.

Example of what caused the problem:

- connected from local machine to Ubuntu or Red Hat
- then tried to SSH from that EC2 instance to another EC2 instance
- the remote EC2 did not have the private key file

## Solution

Run SSH commands from the local terminal where the private key exists.

Correct usage from local machine:

```bash
ssh -i terra-automate-key ubuntu@18.220.182.235
ssh -i terra-automate-key ec2-user@3.15.207.88
ssh -i terra-automate-key ec2-user@16.59.207.122
```

---

# 5. Error: Permission denied (publickey,gssapi-keyex,gssapi-with-mic)

## Error message

```bash
Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
```

## Why it happened

This happened after the key file was not found on the remote server.

Since SSH could not load the private key, authentication failed.

## Solution

Make sure:

- the SSH command is run from the local machine
- the correct private key file is used
- the correct SSH username is used

Correct usernames:

- Ubuntu: `ubuntu`
- Red Hat: `ec2-user`
- Amazon Linux: `ec2-user`

---

# 6. SSH worked for Red Hat

## Successful command

```bash
ssh -i terra-automate-key ec2-user@3.15.207.88
```

## What this confirmed

This proved that:

- the key pair was configured correctly
- the security group allowed SSH
- the Red Hat instance was reachable
- the login username `ec2-user` was correct

---

# 7. Terraform plan and apply succeeded

## Important result

Terraform eventually succeeded with:

```bash
Plan: 9 to add, 0 to change, 0 to destroy.
```

and later:

```bash
Apply complete! Resources: 9 added, 0 changed, 0 destroyed.
```

## Public IPs created

```bash
worker-amazon = 16.59.207.122
worker-redhat = 3.15.207.88
worker-ubuntu = 18.220.182.235
```

This confirmed that:

- `variables.tf` and `ec2.tf` were working
- EC2 instances were created successfully
- security group rules were applied
- the key pair was attached correctly

---

# Final Lessons Learned

## Terraform side

- Run `terraform init` before `terraform validate` and `terraform plan`
- Every attribute used in `each.value` must exist in the variable object
- Hardcoding `instance_type = "t3.micro"` is fine for a simple setup

## SSH side

- `terra-automate-key` is the private key
- `terra-automate-key.pub` is the public key
- SSH should be run from the local machine unless the key is copied to the remote machine
- Use the correct SSH user for each operating system

---

# Useful Commands

## Terraform

```bash
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
terraform output public_ips
```

## SSH

```bash
ssh -i terra-automate-key ubuntu@18.220.182.235
ssh -i terra-automate-key ec2-user@3.15.207.88
ssh -i terra-automate-key ec2-user@16.59.207.122
```

---

# Summary

After creating `variables.tf` and `ec2.tf`, the main problems were:

1. missing AWS provider
2. unsupported `instance_type` attribute
3. confusion about the SSH private key file
4. trying to SSH from inside a remote server without the key
5. authentication failure caused by missing key access

All of these were resolved, and the infrastructure was successfully deployed.


## 3. Error: SSH Key Not Found

### Error
Identity file terra-automate-key not accessible

### Cause
SSH was attempted from inside an EC2 instance.

### Solution
Run SSH from local machine.

---

## 4. Error: Permission Denied

### Error
Permission denied (publickey)

### Cause
Wrong key or wrong user.

### Solution
Use correct user:
- Ubuntu → ubuntu
- RedHat/Amazon → ec2-user

---

## 5. Error: Duplicate Key Pair

### Error
InvalidKeyPair.Duplicate

### Cause
Key already existed in AWS.

### Solution
Deleted key from AWS Console.

---

## 6. Error: Duplicate Security Group

### Error
InvalidGroup.Duplicate

### Cause
Security group already existed.

### Solution
Deleted security group from AWS Console.

---

## 7. Terraform State Mismatch

### Cause
State file deleted locally but AWS resources still existed.

### Solution
Delete resources in AWS OR use terraform import.

---

## Final Result

- Terraform applied successfully
- EC2 instances created
- SSH working

---

## Key Lesson

Terraform depends on state consistency.
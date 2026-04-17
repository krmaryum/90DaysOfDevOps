# Create Multiple EC2 Instances using Terraform

This guide explains how to create multiple EC2 instances using Terraform.

---

## Method 1: Using `count`

This is the simplest way to create multiple identical instances.

```hcl
resource "aws_instance" "my_instance" {
  count         = 3
  ami           = "ami-07062e2a343acc423"
  instance_type = "t3.micro"

  tags = {
    Name = "terra-server-${count.index}"
  }
}
```

### Output

Creates:
- terra-server-0
- terra-server-1
- terra-server-2

---

## Method 2: Using `for_each`

Use this when you want different configurations.

```hcl
resource "aws_instance" "my_instance" {
  for_each = {
    server1 = "t3.micro"
    server2 = "t3.small"
    server3 = "t3.micro"
  }

  ami           = "ami-07062e2a343acc423"
  instance_type = each.value

  tags = {
    Name = each.key
  }
}
```

---

## Method 3: Using Variables

### variables.tf

```hcl
variable "instance_count" {
  default = 2
}
```

### main.tf

```hcl
resource "aws_instance" "my_instance" {
  count         = var.instance_count
  ami           = "ami-07062e2a343acc423"
  instance_type = "t3.micro"

  tags = {
    Name = "server-${count.index}"
  }
}
```

### Run with custom value

```bash
terraform apply -var="instance_count=5"
```

---

## Output Public IPs

```hcl
output "public_ips" {
  value = aws_instance.my_instance[*].public_ip
}
```

---

## Notes

- `count` is best for identical instances
- `for_each` is best for customized instances
- Always ensure your security group allows SSH (port 22)

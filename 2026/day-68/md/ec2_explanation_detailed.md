# Detailed Line-by-Line Explanation of `ec2.tf`

## Full File

```hcl
# Security group
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Security group for EC2 instances"
}

# Inbound rule - HTTP (web traffic, e.g. Nginx/Apache)
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Inbound rule - HTTPS (secure web traffic)
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# Inbound rule - SSH (remote administration)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Outbound rule - allow all traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# EC2 instances
resource "aws_instance" "servers" {
  for_each = var.instances

  ami                    = each.value.ami
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
  }
}

# Output all public IPs
output "public_ips" {
  value = {
    for name, instance in aws_instance.servers :
    name => instance.public_ip
  }
}
```

---

## Line-by-Line Notes

### `# Security group`
This is a comment.
It tells the reader that the next resource creates a security group.

---

### `resource "aws_security_group" "my_security_group" {`
This starts an AWS security group resource.

Breakdown:
- `resource` means Terraform will create something real
- `aws_security_group` is the AWS resource type
- `my_security_group` is the Terraform local name

Terraform refers to it later as:
```hcl
aws_security_group.my_security_group
```

A security group acts like a firewall for EC2 instances.

---

### `name = "my-security-group"`
This sets the AWS name of the security group.

This is the visible name in AWS.

---

### `description = "Security group for EC2 instances"`
This describes the purpose of the security group.

Helpful for readability in AWS console and Terraform code.

---

### `}`
Closes the security group resource block.

---

## HTTP Ingress Rule

### `# Inbound rule - HTTP (web traffic, e.g. Nginx/Apache)`
This comment explains that the next rule opens HTTP.

---

### `resource "aws_vpc_security_group_ingress_rule" "allow_http" {`
This starts an inbound rule resource.

- `aws_vpc_security_group_ingress_rule` means incoming traffic rule
- `allow_http` is the Terraform resource name

---

### `security_group_id = aws_security_group.my_security_group.id`
This attaches the rule to the security group created earlier.

Without this, Terraform would not know which security group gets the rule.

---

### `cidr_ipv4 = "0.0.0.0/0"`
This means traffic is allowed from anywhere on the internet.

`0.0.0.0/0` means all IPv4 addresses.

For HTTP and HTTPS, this is common for public web servers.

---

### `from_port = 80`
Start of allowed port range.

---

### `ip_protocol = "tcp"`
This allows TCP traffic.

HTTP uses TCP.

---

### `to_port = 80`
End of allowed port range.

Because both `from_port` and `to_port` are 80, only port 80 is open.

---

### `}`
Closes the HTTP rule block.

---

## HTTPS Ingress Rule

### `# Inbound rule - HTTPS (secure web traffic)`
Comment describing secure web traffic.

---

### `resource "aws_vpc_security_group_ingress_rule" "allow_https" {`
Starts the HTTPS ingress rule.

---

### `security_group_id = aws_security_group.my_security_group.id`
Attaches the rule to the same security group.

---

### `cidr_ipv4 = "0.0.0.0/0"`
Allows access from anywhere on the internet.

This is normal for a public HTTPS website.

---

### `from_port = 443`
Starts allowed port range at 443.

---

### `ip_protocol = "tcp"`
HTTPS uses TCP.

---

### `to_port = 443`
Ends allowed port range at 443.

So only port 443 is open.

---

### `}`
Closes the HTTPS rule block.

---

## SSH Ingress Rule

### `# Inbound rule - SSH (remote administration)`
Comment explaining that the next rule is for SSH.

---

### `resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {`
Starts the SSH ingress rule.

---

### `security_group_id = aws_security_group.my_security_group.id`
Attaches the SSH rule to your security group.

---

### `cidr_ipv4 = "0.0.0.0/0"`
This allows SSH from anywhere.

This works for testing, but it is not recommended for production.

Safer option:
```hcl
cidr_ipv4 = "YOUR_PUBLIC_IP/32"
```

That limits SSH access to your IP only.

---

### `from_port = 22`
Starts the allowed port range at 22.

---

### `ip_protocol = "tcp"`
SSH uses TCP.

---

### `to_port = 22`
Ends the range at 22.

So only port 22 is open.

---

### `}`
Closes the SSH rule block.

---

## Egress Rule

### `# Outbound rule - allow all traffic`
Comment explaining that the next block handles outgoing traffic.

---

### `resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {`
Starts the outbound rule resource.

Egress means traffic leaving the instance.

---

### `security_group_id = aws_security_group.my_security_group.id`
Attaches the outbound rule to the same security group.

---

### `cidr_ipv4 = "0.0.0.0/0"`
Allows outgoing traffic to any IPv4 address.

---

### `ip_protocol = "-1"`
`-1` means all protocols.

So this rule allows all outbound traffic.

This is commonly needed for:
- package installation
- OS updates
- internet access
- API calls

---

### `}`
Closes the outbound rule block.

---

## EC2 Resource

### `# EC2 instances`
Comment marking the EC2 section.

---

### `resource "aws_instance" "servers" {`
Starts the EC2 instance resource block.

- `aws_instance` is the AWS EC2 resource type
- `servers` is Terraform’s resource name

---

### `for_each = var.instances`
This is one of the most important lines.

It tells Terraform:
- read every entry inside `var.instances`
- create one EC2 instance for each entry

So if `variables.tf` contains 4 server entries, Terraform creates 4 EC2 instances.

---

### `ami = each.value.ami`
For each server, Terraform reads the AMI value from the variable.

Examples:
- Ubuntu servers use Ubuntu AMI
- Red Hat server uses RHEL AMI
- Amazon server uses Amazon Linux AMI

---

### `instance_type = "t3.micro"`
Sets the EC2 instance type.

This controls:
- CPU
- memory
- pricing

`t3.micro` is a small instance, good for:
- testing
- learning
- simple workloads

---

### `key_name = aws_key_pair.my_key_pair.key_name`
This attaches an AWS key pair to the EC2 instance.

This is needed for SSH login.

Important:
you must already have a Terraform key pair resource named:
```hcl
aws_key_pair.my_key_pair
```

---

### `vpc_security_group_ids = [aws_security_group.my_security_group.id]`
This attaches the security group to the instance.

That means all instances will use the same firewall rules:
- HTTP
- HTTPS
- SSH
- outbound access

---

## Root Block Device

### `root_block_device {`
Starts the storage configuration block for the instance’s main disk.

---

### `volume_size = 10`
Sets the root disk size to 10 GB.

---

### `volume_type = "gp3"`
Sets the disk type to gp3.

`gp3` is a general purpose SSD volume in AWS.

It is commonly used because it is:
- fast
- flexible
- cost effective

---

### `}`
Closes the root block device block.

---

## Tags

### `tags = {`
Starts the AWS tags block.

Tags help label and organize AWS resources.

---

### `Name = each.key`
This dynamically sets the Name tag.

Since `each.key` comes from the map key in `var.instances`, the instance names become:
- master-ubuntu
- worker-ubuntu
- worker-redhat
- worker-amazon

This is very helpful in AWS console.

---

### `}`
Closes the tags block.

---

### `}`
Closes the EC2 instance resource block.

---

## Output Block

### `# Output all public IPs`
Comment explaining the output block.

---

### `output "public_ips" {`
Starts an output block named `public_ips`.

Outputs are values Terraform prints after `apply`.

---

### `value = {`
Starts the map output value.

---

### `for name, instance in aws_instance.servers :`
This loops through all created EC2 instances.

- `name` is the key, like `master-ubuntu`
- `instance` is the actual EC2 resource object

---

### `name => instance.public_ip`
This builds a result map where:
- key = server name
- value = server public IP

Example result:
```hcl
{
  "master-ubuntu" = "54.x.x.x"
  "worker-ubuntu" = "18.x.x.x"
}
```

---

### `}`
Closes the value map.

---

### `}`
Closes the output block.

---

## Final Summary

This file creates the actual AWS infrastructure.

It:
- creates one security group
- opens ports 80, 443, and 22
- allows all outbound traffic
- creates one EC2 instance for each entry in `var.instances`
- tags each instance with its map key
- outputs all public IP addresses

---

## How It Connects with `variables.tf`

`variables.tf` provides the data.

`ec2.tf` reads that data using:
```hcl
var.instances
```

Then `for_each` loops over that map and builds all servers automatically.

---

## Simple Mental Model

Think of:
- `variables.tf` as the server list
- `ec2.tf` as the construction worker

The list says what to build.
The EC2 file actually builds it.

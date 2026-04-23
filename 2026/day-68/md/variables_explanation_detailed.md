# Detailed Line-by-Line Explanation of `variables.tf`

## Full File

```hcl
# This is a simple variable of type map

variable "instances" {
  description = "Map of instance names to AMI IDs, SSH users, and OS family"

  type = map(object({
    ami       = string
    user      = string
    os_family = string
  }))

  # Default values for instances
  default = {
    "master-ubuntu" = {
      ami       = "ami-07062e2a343acc423" # Ubuntu Server 24.04 LTS (HVM)
      user      = "ubuntu"
      os_family = "ubuntu"
    }

    "worker-ubuntu" = {
      ami       = "ami-07062e2a343acc423" # Ubuntu Server 24.04 LTS (HVM)
      user      = "ubuntu"
      os_family = "ubuntu"
    }

    "worker-redhat" = {
      ami       = "ami-0a951f007be151ff9" # Red Hat Enterprise Linux 10 (HVM)
      user      = "ec2-user"
      os_family = "redhat"
    }

    "worker-amazon" = {
      ami       = "ami-0a1b6a02658659c2a" # Amazon Linux 2023
      user      = "ec2-user"
      os_family = "amazon"
    }
  }
}
```

---

## Line-by-Line Notes

### `# This is a simple variable of type map`
This is a comment.
Comments are only for humans reading the file.
Terraform ignores this line.

---

### `variable "instances" {`
This starts a Terraform variable block.

- `variable` means you are declaring an input variable.
- `"instances"` is the variable name.
- Terraform will later refer to it as:

```hcl
var.instances
```

This variable stores the data for multiple EC2 instances.

---

### `description = "Map of instance names to AMI IDs, SSH users, and OS family"`
This is a description of the variable.

It helps explain:
- what the variable is for
- what data it stores

This is useful for:
- readability
- team projects
- documentation

It does not create resources. It only explains the variable.

---

### `type = map(object({`
This tells Terraform the exact structure expected for this variable.

Breakdown:

- `map(...)` means a collection of key-value pairs
- each key is usually a string
- each value must follow the object format inside

This is useful because:
- Terraform validates the structure
- prevents wrong input
- keeps your code organized

---

### `ami = string`
Inside each object, `ami` must be a string.

This value stores the AMI ID for the EC2 instance.

Example:
```hcl
ami = "ami-07062e2a343acc423"
```

AMI means Amazon Machine Image.
It defines which operating system image the EC2 instance will launch.

---

### `user = string`
This says the `user` field must also be a string.

This stores the SSH login username for that OS.

Examples:
- Ubuntu usually uses `ubuntu`
- Red Hat usually uses `ec2-user`
- Amazon Linux usually uses `ec2-user`

This becomes useful later when connecting with SSH or Ansible.

---

### `os_family = string`
This says the `os_family` field must also be a string.

This stores the operating system family name.

Examples:
- `ubuntu`
- `redhat`
- `amazon`

This is helpful for:
- grouping servers by OS
- using conditional logic in playbooks
- writing cleaner automation

---

### `}))`
This closes:
- the object definition
- the map type definition

So now Terraform knows that:
- `instances` is a map
- each map value must be an object
- each object must contain `ami`, `user`, and `os_family`

---

### `# Default values for instances`
This is another comment.

It tells the reader that the next section contains the default values for the variable.

---

### `default = {`
This starts the default value block.

If you do not provide another value from:
- `terraform.tfvars`
- CLI input
- environment variables

Terraform will use this default map.

---

## Instance Entries

### `"master-ubuntu" = {`
This starts the first item in the map.

- `"master-ubuntu"` is the key
- the object on the right is the value

This key often becomes useful for naming resources later.

Example:
```hcl
Name = each.key
```

Then the AWS instance name becomes `master-ubuntu`.

---

### `ami = "ami-07062e2a343acc423"`
This is the AMI ID for the master Ubuntu instance.

It tells AWS which image to use to launch the server.

Since this is Ubuntu, it will boot with Ubuntu installed.

---

### `# Ubuntu Server 24.04 LTS (HVM)`
This comment explains what the AMI represents.

- Ubuntu Server
- version 24.04 LTS
- HVM virtualization type

This helps humans understand the AMI without searching manually.

---

### `user = "ubuntu"`
This sets the SSH user for this instance.

When you connect, you will likely use:
```bash
ssh -i key.pem ubuntu@public_ip
```

---

### `os_family = "ubuntu"`
This labels the operating system family.

This is useful for automation later.

For example, in Ansible you might run Ubuntu-specific tasks when:
- `os_family = "ubuntu"`

---

### `}`
This closes the `master-ubuntu` object.

---

### `"worker-ubuntu" = {`
This begins another instance definition.

This instance is a worker node using Ubuntu.

The structure is the same as `master-ubuntu`, but the key is different.

That means Terraform can create a separate instance with a different name.

---

### `ami = "ami-07062e2a343acc423"`
Same Ubuntu AMI as the master node.

This means both Ubuntu servers use the same OS image.

---

### `user = "ubuntu"`
SSH user for Ubuntu remains `ubuntu`.

---

### `os_family = "ubuntu"`
Marks this instance as Ubuntu family too.

---

### `}`
Closes the `worker-ubuntu` object.

---

### `"worker-redhat" = {`
This begins the Red Hat instance definition.

This key identifies the server as a Red Hat worker node.

---

### `ami = "ami-0a951f007be151ff9"`
This is the AMI ID for Red Hat Enterprise Linux.

Terraform will use this image to launch the instance.

---

### `# Red Hat Enterprise Linux 10 (HVM)`
This comment explains the AMI.

It tells you this image is:
- RHEL 10
- HVM type

---

### `user = "ec2-user"`
This sets the SSH login username.

For many Red Hat based AWS images, the default login user is `ec2-user`.

You would connect like:
```bash
ssh -i key.pem ec2-user@public_ip
```

---

### `os_family = "redhat"`
This labels the server as Red Hat family.

This helps later for:
- automation
- conditional configuration
- package manager decisions like `dnf`

---

### `}`
Closes the `worker-redhat` object.

---

### `"worker-amazon" = {`
This begins the Amazon Linux worker definition.

This is another server entry in the same map.

---

### `ami = "ami-0a1b6a02658659c2a"`
This AMI ID is for Amazon Linux 2023.

This tells AWS to launch that operating system image.

---

### `# Amazon Linux 2023`
This comment explains the AMI type.

---

### `user = "ec2-user"`
Amazon Linux commonly uses `ec2-user` as the default SSH username.

---

### `os_family = "amazon"`
This labels the OS family as Amazon Linux.

Useful later for:
- targeting package installation steps
- OS-specific playbooks
- inventory grouping

---

### `}`
Closes the `worker-amazon` object.

---

### `}`
This closes the `default` map.

At this point, all instance definitions are complete.

---

### `}`
This closes the entire variable block.

So the whole variable is now fully defined.

---

## Final Summary

This file does not create EC2 instances by itself.

It only stores structured data for instances.

It gives Terraform:
- instance names
- AMI IDs
- SSH users
- OS family types

Then another file like `ec2.tf` can read this variable and create resources from it.

---

## Simple Mental Model

Think of this file like a table of server definitions.

Each row contains:
- server name
- operating system image
- SSH username
- OS family

Terraform later loops through these rows and creates real AWS instances.

# ec2.tf Explanation

## Purpose
This file creates AWS infrastructure:
- Security group
- Inbound/outbound rules
- EC2 instances
- Outputs

## Step by Step

### Security Group
Creates a firewall for instances.

### HTTP Rule (Port 80)
Allows web traffic.

### HTTPS Rule (Port 443)
Allows secure web traffic.

### SSH Rule (Port 22)
Allows remote login.

### Outbound Rule
Allows all outgoing traffic.

### EC2 Resource
Uses:
- for_each = var.instances

Creates multiple EC2 instances dynamically.

### Key Parts
- ami = each.value.ami
- instance_type = t3.micro
- key_name = SSH key
- security group attached

### Root Block Device
Defines disk:
- 10 GB
- gp3 SSD

### Tags
Names each instance using:
- each.key

### Output
Displays public IPs of all instances.

## Key Idea
This file builds infrastructure using data from variables.tf.

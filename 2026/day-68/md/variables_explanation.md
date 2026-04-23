# variables.tf Explanation

## Purpose
This file defines a variable called `instances` that stores configuration for multiple EC2 instances.

## Step by Step

### variable "instances"
Creates a variable named `instances`.

### description
Explains what the variable is used for.

### type
Defines the structure:
- map = multiple items
- object = each item has:
  - ami (string)
  - user (string)
  - os_family (string)

### default
Provides actual values.

Each entry:
- Key = instance name
- Value = configuration

Example:
- master-ubuntu → Ubuntu server
- worker-redhat → Red Hat server
- worker-amazon → Amazon Linux server

## Key Idea
This file acts as a data source for EC2 creation.

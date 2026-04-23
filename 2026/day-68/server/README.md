Day 68 of 90 Days of DevOps: Introduction to Ansible and Inventory Setup

Today I focused on understanding how configuration management fits into the DevOps lifecycle and how Ansible helps automate post-provisioning tasks.

After using Terraform to provision infrastructure, I explored how Ansible can be used to configure and manage servers efficiently using an agentless approach over SSH.

What I worked on:

- Installed and configured Ansible on my control node (Ubuntu 24.04 on WSL)
- Provisioned 3 EC2 instances using Terraform:
  - Ubuntu (web server)
  - Red Hat (application server)
  - Amazon Linux (database server)
- Created an inventory file to define and organize managed nodes
- Grouped hosts logically based on roles (web, app, db)
- Automated inventory generation using a shell script and Terraform output
- Configured ansible.cfg to simplify command execution
- Ran multiple ad-hoc commands to:
  - check uptime, memory, and disk usage
  - install packages
  - copy files across servers
- Explored group-of-groups and patterns for flexible host targeting
- Verified connectivity using Ansible ping module

Key concepts learned:

- Ansible is agentless and uses SSH for communication
- Inventory files define infrastructure structure and access details
- Ad-hoc commands are useful for quick tasks, while playbooks are better for repeatable automation
- Groups and patterns help scale operations across multiple servers
- The --become flag enables privilege escalation for administrative tasks

Workflow implemented:

Terraform → Provision Infrastructure  
Shell Script → Automate Setup  
Inventory → Organize Hosts  
Ansible → Configure Servers  

This project gave me a clear understanding of how infrastructure provisioning and configuration management work together to build scalable and reproducible systems.

Looking forward to moving into Ansible playbooks and roles next.



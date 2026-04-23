# DevOps Mock Interview - Ansible Project

## Introduction
This document contains a mock DevOps interview based on an Ansible + Terraform project.

---

## Q1: What is Ansible?
Ansible is a configuration management and automation tool used to configure and manage servers after infrastructure is provisioned.

## Q2: What is Configuration Management?
It ensures systems remain in a consistent and desired state using automation.

## Q3: What does agentless mean?
Ansible does not require agents on managed nodes; it uses SSH.

## Q4: Explain your architecture
Terraform provisions infrastructure → Script automates → Inventory generated → Ansible configures servers.

## Q5: What is inventory?
A file that defines hosts and groups for Ansible.

## Q6: How did you handle dynamic IPs?
Using Terraform output and jq script to generate inventory dynamically.

## Q7: What are modules?
Reusable units like apt, yum, copy, ping.

## Q8: command vs shell
command: no pipes
shell: supports pipes and redirects

## Q9: What is --become?
Runs tasks with elevated privileges (sudo).

## Q10: Explain apt command
Installs git on ubuntu_web using root privileges.

## Q11: What is :children?
Group of groups in inventory.

## Q12: Pattern all:!amz_db
Targets all except database servers.

## Q13: Why group-of-groups?
Simplifies managing multiple related hosts.

## Q14: Debug UNREACHABLE
Check SSH, keys, security group.

## Q15: Debug FAILED
Check permissions, module, command.

## Q16: Terraform + Ansible?
Terraform provisions, Ansible configures.

## Q17: Ad-hoc vs Playbook
Ad-hoc = quick
Playbook = repeatable

## Q18: Improvements
Add playbooks, roles, security improvements.

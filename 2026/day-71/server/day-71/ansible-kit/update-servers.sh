#!/bin/bash
echo
echo ===== UPDATING ALL SERVERS =====
ansible-playbook ansible-practice/playbooks/update-servers.yml
echo ===== ALL SERVERS ARE UPDATED =====

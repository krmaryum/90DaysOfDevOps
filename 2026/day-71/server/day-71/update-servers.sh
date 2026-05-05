#!/bin/bash
echo
echo ===== UPDATING ALL SERVERS =====
ansible-playbook update-servers.yml
echo ===== ALL SERVERS ARE UPDATED =====

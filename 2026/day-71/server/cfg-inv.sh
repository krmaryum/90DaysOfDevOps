#!/bin/bash

echo "===== Updating ansible configuration file ====="
cat ansible.cfg > ./ansible-practice/ansible.cfg
echo "===== Updated ansible.cfg ====="

echo
echo "===== Updating inventory file ====="
cat inventory.ini > ./ansible-practice/inventory.ini
echo "===== Updated inventory file ====="


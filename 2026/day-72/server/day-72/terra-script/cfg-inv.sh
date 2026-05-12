#!/bin/bash

echo "===== Updating ansible configuration file ====="
cat ansible.cfg > ../ansible-docker-project/ansible.cfg
echo "===== Updated ansible.cfg ====="

echo
echo "===== Updating inventory file ====="
cat inventory.ini > ../ansible-docker-project/inventory.ini
echo "===== Updated inventory file ====="


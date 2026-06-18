#!/bin/bash

# ==========================================================
# Script Title : Simple System Health Check
# Description  : This script checks basic Linux system info
#                and verifies required commands are installed.
# Author       : Khalid Khan
# ==========================================================

echo "===================================="
echo " Simple System Health Check Started "
echo "===================================="

echo
echo "Checking hostname..."
hostname

echo
echo "Checking current user..."
whoami

echo
echo "Checking current directory..."
pwd

echo
echo "Checking operating system..."
uname -a

echo
echo "Checking disk usage..."
df -h

echo
echo "Checking required commands..."

required_commands=("bash" "git" "pwd" "hostname" "df")

for command in "${required_commands[@]}"
do
  if command -v "$command" >/dev/null 2>&1; then
    echo "$command is installed"
  else
    echo "Error: $command is not installed" >&2
    exit 1
  fi
done

echo
echo "All required commands are available."
echo "System health check completed successfully."

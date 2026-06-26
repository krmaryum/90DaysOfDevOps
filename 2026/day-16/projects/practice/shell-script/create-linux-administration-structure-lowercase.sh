#!/bin/bash

###############################################################################
# Script Name : create-linux-administration-structure.sh
# Description : Creates a professional folder structure for Linux Administration
#               study notes and RHCSA preparation.
#
# Author      : Muhammad Khalid Khan
# GitHub      : https://github.com/krmaryum
#
# Usage:
#   chmod +x create-linux-administration-structure.sh
#   ./create-linux-administration-structure.sh
###############################################################################

mkdir -p linux-administration/{01-linux-fundamentals,02-users-and-groups,03-permissions-and-acl,04-selinux,05-file-descriptors-and-redirection,06-linux-shell-and-environment,07-bash-scripting,08-networking,09-systemd,10-storage-and-lvm,11-rhcsa-labs}

touch "linux-administration/06-linux-shell-and-environment/linux-study-notes-\$0-vs-\$shell.md"
touch "linux-administration/06-linux-shell-and-environment/login-vs-non-login-shell.md"
touch "linux-administration/06-linux-shell-and-environment/bashrc-vs-profile.md"
touch "linux-administration/06-linux-shell-and-environment/path-environment-variable.md"
touch "linux-administration/06-linux-shell-and-environment/aliases.md"
touch "linux-administration/06-linux-shell-and-environment/shell-expansion.md"
touch "linux-administration/06-linux-shell-and-environment/readme.md"

echo "linux administration folder structure created successfully."

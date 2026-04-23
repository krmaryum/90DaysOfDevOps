#!/bin/bash
set -euo pipefail

OUTPUT_FILE="inventory.ini"
TEMP_FILE="$(mktemp)"

if ! command -v jq >/dev/null 2>&1; then
  echo "Error: jq is not installed."
  exit 1
fi

echo "Getting Terraform output..."
terraform output -json ansible_inventory > "$TEMP_FILE"

if [ ! -s "$TEMP_FILE" ]; then
  echo "Error: ansible_inventory output is empty."
  rm -f "$TEMP_FILE"
  exit 1
fi

{
  echo "[ubuntu_web]"
  jq -r 'to_entries[]
    | select(.value.os=="ubuntu")
    | "\(.key) ansible_host=\(.value.ip) ansible_user=\(.value.user)"' "$TEMP_FILE"

  echo
  echo "[redhat_app]"
  jq -r 'to_entries[]
    | select(.value.os=="redhat")
    | "\(.key) ansible_host=\(.value.ip) ansible_user=\(.value.user)"' "$TEMP_FILE"

  echo
  echo "[amz_db]"
  jq -r 'to_entries[]
    | select(.value.os=="amazon")
    | "\(.key) ansible_host=\(.value.ip) ansible_user=\(.value.user)"' "$TEMP_FILE"

  echo
  echo "[servers]"
  jq -r 'keys[]' "$TEMP_FILE"

  echo
  echo "[all:vars]"
  echo "ansible_python_interpreter=/usr/bin/python3"
  echo "ansible_ssh_private_key_file=./terra-automate-key"
} > "$OUTPUT_FILE"

rm -f "$TEMP_FILE"

echo "Inventory generated successfully: $OUTPUT_FILE"

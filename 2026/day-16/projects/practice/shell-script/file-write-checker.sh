#!/bin/bash

# ==========================================================
# Script Title : File Write Permission Checker and Finder
# Description  : This script asks the user for a file name.
#                If the file exists and has write permission,
#                the user can append text to it.
#                If the file is not found, it searches inside
#                the user's home directory.
# Author       : Khalid Khan
# ==========================================================

read -p "Enter the name of the file: " file_name

if [ -f "$file_name" ]; then
  if [ -w "$file_name" ]; then
    echo "Type something. Press Ctrl+D to save and exit."
    cat >> "$file_name"
  else
    echo "The file does not have write permission." >&2
  fi
else
  echo "File not found. Searching in home directory..."
  find "$HOME" -type f -name "$file_name" 2>/dev/null
fi

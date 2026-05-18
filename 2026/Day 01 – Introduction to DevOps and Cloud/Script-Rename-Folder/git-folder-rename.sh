#!/bin/bash

# git-folder-rename.sh
# Safely rename folders in Git repositories

echo "======================================"
echo " Git Folder Rename Utility"
echo "======================================"

# Check if inside a Git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: This is not a Git repository."
    exit 1
fi

# Read old folder name
read -p "Enter old folder name: " OLD_NAME

# Verify old folder exists
if [ ! -d "$OLD_NAME" ]; then
    echo "Error: Folder '$OLD_NAME' does not exist."
    exit 1
fi

# Read new folder name
read -p "Enter new folder name: " NEW_NAME

# Rename using Git
git mv "$OLD_NAME" "$NEW_NAME"

# Check status
echo ""
echo "Git status:"
git status

# Ask for commit
echo ""
read -p "Do you want to commit the rename now? [y/N]: " COMMIT_CHOICE

if [[ "$COMMIT_CHOICE" =~ ^[Yy]$ ]]; then
    read -p "Enter commit message: " COMMIT_MSG

    git commit -m "$COMMIT_MSG"

    echo ""
    read -p "Do you want to push changes now? [y/N]: " PUSH_CHOICE

    if [[ "$PUSH_CHOICE" =~ ^[Yy]$ ]]; then
        git push
    fi
fi

echo ""
echo "Folder rename process completed successfully."

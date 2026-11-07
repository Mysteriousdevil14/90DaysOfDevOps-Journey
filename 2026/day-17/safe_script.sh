#!/bin/bash
set -e
echo "Creating directory..."
mkdir /tmp/devops-test || echo "Directory already exists"
echo "Changing directory..."
cd /tmp/devops-test || echo "Failed to cd"
echo "Creating file.."
touch test.txt || echo "Failed to create file"
echo "Script completed successfully"

#!/bin/bash

SSH_KEY_FILE=ansible_ssh_key

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -C "ansible" -f $SSH_KEY_FILE -P ""

# Set appropriate permissions
chmod 600 $SSH_KEY_FILE
chmod 644 $SSH_KEY_FILE.pub

echo "SSH key pair 'ansible' created successfully!"
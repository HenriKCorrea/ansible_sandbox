#!/bin/bash

# Build the Docker image
docker build -t ansible_managed_node:latest \
    --build-arg ANSIBLE_SSH_KEY_PUB=FARINHA/.ssh/ansible.pub \
    .

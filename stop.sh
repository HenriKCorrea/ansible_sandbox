#!/bin/bash

# Stop and remove containers, networks, and volumes defined in the Docker Compose file
docker-compose down

ssh-keygen -R [localhost]:2221
ssh-keygen -R [localhost]:2222
ssh-keygen -R [localhost]:2223
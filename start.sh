#!/bin/bash

bash stop.sh

# Run docker-compose up
docker-compose up -d

# Wait for services to be up and running
services=$(docker-compose config --services)

for service in $services
do
  while true; do
    status=$(docker-compose ps -q $service | xargs docker inspect -f '{{.State.Status}}')
    if [ "$status" = "running" ]; then
      break
    else
      echo "Waiting for $service..."
      sleep 5
    fi
  done
done

echo "All services are up and running."

ssh-keyscan -H -p 2221 localhost >> ~/.ssh/known_hosts
ssh-keyscan -H -p 2222 localhost >> ~/.ssh/known_hosts
ssh-keyscan -H -p 2223 localhost >> ~/.ssh/known_hosts
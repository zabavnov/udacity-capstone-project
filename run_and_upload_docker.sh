#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
docker build -t capstoneproject:latest .
# Step 2:
# List docker images
docker image ls

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath=zabavnov/capstoneproject

# Step 2:
# Authenticate & tag
docker login --username zabavnov
docker tag ml-microservice $dockerpath
echo "Docker ID and Image: $dockerpath"

# Step 3:
# Push image to a docker repository
docker push $dockerpath

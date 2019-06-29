#!/bin/sh

DOCKER_IMAGE_NAME="postgres-with-dvd-rental-db"
DOCKER_IMAGE_VERSION="1.0"

## Cleanup previous docker images
docker rmi ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}

## Build new image
docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} .

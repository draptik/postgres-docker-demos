#!/bin/sh

## ========================================
## Docker config values...
INTERNAL_DOCKER_PORT=5432
EXTERNAL_DOCKER_PORT=5432
DOCKER_REMOVE_CONTAINER_AFTER_EXIT="--rm"
# DOCKER_REMOVE_CONTAINER_AFTER_EXIT="--rm"
# DOCKER_REMOVE_CONTAINER_AFTER_EXIT=""

DOCKER_CONTAINER_NAME="postgres-dvd-rental"
DOCKER_IMAGE_NAME="postgres-with-dvd-rental-db:1.0"
DOCKER_ADDITIONAL_CMD=""
## ========================================

## ========================================
## Setup 
COMMAND="docker run \
    ${DOCKER_REMOVE_CONTAINER_AFTER_EXIT} \
    -p ${INTERNAL_DOCKER_PORT}:${EXTERNAL_DOCKER_PORT} \
    --name ${DOCKER_CONTAINER_NAME} \
    ${DOCKER_IMAGE_NAME} \
    ${DOCKER_ADDITIONAL_CMD}"
## ========================================

echo $COMMAND

## Run docker container
eval $COMMAND

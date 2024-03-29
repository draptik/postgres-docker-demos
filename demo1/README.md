# Demo1: DVD Rental sample database

## TL;DR

The following command creates a docker image with postgres and adds the DVD Rental example database.

```sh
./docker-build.sh && ./docker-run.sh
```

- URL: `localhost`
- Port: `5432`
- Username & password: `postgres`

View with

- pgAdmin: `http://127.0.0.1:39007/browser/`

## Goal

Self-contained docker container:

- postgres
- dvd-rental demo
- default postgres user and pw

## Configuration overview

- `docker-build.sh`
  - `Dockerfile`
    - copies sample-data into docker container
    - executes `create-db.sh`:
      - create database
      - import data from tar file into newly created database
- `docker-run.sh`: convenience wrapper around `docker run ...`

Not included:

- changing postres user/pw
- using docker mounts or volumes (the db data is in the docker container and bound to its livecycle)

## Create docker image

This demo uses a `Dockerfile` to create and populate the database. It requires the database content downloaded from:
[http://www.postgresqltutorial.com/postgresql-sample-database/](http://www.postgresqltutorial.com/postgresql-sample-database/)

The file `dvdrental.tar` should be located in the folder `sample-data`.

File `create_db.sh`:

```sh
#!/bin/sh

psql -U postgres -c 'create database dvdrental'

pg_restore -U postgres -d dvdrental ./sample-data/dvdrental.tar
```

File `Dockerfile`:

```sh
FROM postgres:11.4

## paths must be absolute: no soft-links allowed!
COPY sample-data/dvdrental.tar /tmp/
COPY create_db.sh /docker-entrypoint-initdb.d/create_db.sh
```

File: `docker-build.sh`

```sh
#!/bin/sh

DOCKER_IMAGE_NAME="postgres-with-dvd-rental-db"
DOCKER_IMAGE_VERSION="1.0"

## Cleanup previous docker images
docker rmi ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}

## Build new image
docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} .
```

This will create 3 images:

```text
docker images -a
REPOSITORY                    TAG                 IMAGE ID            CREATED             SIZE
postgres-with-dvd-rental-db   1.0                 f9d74f0900f2        About an hour ago   315MB
<none>                        <none>              9408651ed426        About an hour ago   315MB
postgres                      11.4                79db2bf18b4a        5 days ago          312MB
```

File: `docker-run.sh`

```sh
#!/bin/sh

## ========================================
## Docker config values...
INTERNAL_DOCKER_PORT=5432
EXTERNAL_DOCKER_PORT=5432
DOCKER_REMOVE_CONTAINER_AFTER_EXIT="--rm"

DOCKER_CONTAINER_NAME="postgres-dvd-rental"
DOCKER_IMAGE_NAME="postgres-with-dvd-rental-db:1.0"
## ========================================

## ========================================
## Setup
COMMAND="docker run \
    ${DOCKER_REMOVE_CONTAINER_AFTER_EXIT} \
    -p ${INTERNAL_DOCKER_PORT}:${EXTERNAL_DOCKER_PORT} \
    --name ${DOCKER_CONTAINER_NAME} \
    ${DOCKER_IMAGE_NAME}"
## ========================================

echo $COMMAND

## Run docker container
eval $COMMAND
```

## Idea

- [https://github.com/tadaken3/postgres-dvdrental-database-dockerfiles](https://github.com/tadaken3/postgres-dvdrental-database-dockerfiles)

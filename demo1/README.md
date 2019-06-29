# Demo1: DVD Rental sample database

## TL;DR

The following command creates a docker image with postgres and adds the DVD Rental example database.

```sh
./docker-build.sh && ./docker-run.sh
```

- URL: `localhost`
- Port: `5432`
- Username & password: `postgres`

## TODO

Figure out how to provide this postgres docker container for dedicated postgres user `demouser` with password `demopw`.

Ideally using `docker-compose` like in [`demo2`](../demo2/README.md): Less ceremony, easier.

My failed attempts are commented in [`create_db.sh`](create_db.sh).

## Create docker image

This demo uses a `Dockerfile` to create and populate the database. It requires the database content downloaded from:
http://www.postgresqltutorial.com/postgresql-sample-database/

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

```
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
```

## Idea

https://github.com/tadaken3/postgres-dvdrental-database-dockerfiles

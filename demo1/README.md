# Demo1: DVD Rental sample database

Idea: https://github.com/tadaken3/postgres-dvdrental-database-dockerfiles

## TL;DR

```sh
./docker-build.sh && ./docker-run.sh
```

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

```docker
FROM postgres:11.4

COPY ../sample-data/dvdrental.tar /tmp/
COPY create_db.sh /docker-entrypoint-initdb.d/
```

File: `docker-build.sh`

```sh
docker build .
```

This will create 3 images:

```
docker images -a                                                                                                                             REPOSITORY                    TAG                 IMAGE ID            CREATED             SIZE
postgres-with-dvd-rental-db   1.0                 f9d74f0900f2        About an hour ago   315MB
<none>                        <none>              9408651ed426        About an hour ago   315MB
postgres                      11.4                79db2bf18b4a        5 days ago          312MB
```




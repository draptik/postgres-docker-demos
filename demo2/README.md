# Demo2

## TL;DR

This example creates an empty postgres database using `docker-compose`.

Usage:

```sh
# Start
docker-compose up

# Shutdown (remove docker container)
docker-compose down
```

## Details

File `init.sql`

```sql
CREATE DATABASE "demo2";
CREATE USER demouser WITH PASSWORD 'demopw';
GRANT ALL PRIVILEGES ON DATABASE "demo2" to demouser;
```

File `docker-compose.yaml`

```yaml
version: '3.5'

services:

  postgres:
    container_name: demo2
    image: postgres:11.4
    ports:
    - 5432:5432
    volumes:
    - ./init.sql:/docker-entrypoint-initdb.d/init.sql
```

## Idea

[https://github.com/PacktPublishing/Hands-On-Domain-Driven-Design-with-.NET-Core/blob/master/Chapter09/ef-core/docker-compose.yml](https://github.com/PacktPublishing/Hands-On-Domain-Driven-Design-with-.NET-Core/blob/master/Chapter09/ef-core/docker-compose.yml)

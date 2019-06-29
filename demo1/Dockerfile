FROM postgres:11.4

## paths must be absolute: no soft-links allowed!
COPY sample-data/dvdrental.tar /tmp/
COPY create_db.sh /docker-entrypoint-initdb.d/create_db.sh

#!/bin/sh

## This works:
psql -U postgres -c 'create database dvdrental'
pg_restore -U postgres -d dvdrental ./tmp/dvdrental.tar

# ---------------
## Another try
# psql -U postgres -c "create role demouser"
# psql -U postgres -c "alter role demouser password 'demopw'"
# psql -U postgres -c "alter role demouser with login"
# psql -U postgres -c "grant all privileges on all tables in schema public to demouser"
# psql -U postgres -c "grant all privileges on all sequences in schema public to demouser"
# psql -U postgres -c "create database dvdrental"
# psql -U postgres -c "grant all privileges on database dvdrental to demouser"
# psql -U postgres -c "alter default privileges grant all on tables to demouser"
# pg_restore -U postgres -d dvdrental ./tmp/dvdrental.tar


# ==============================================
## My first failed attempt...
# psql -U postgres -c "create database dvdrental"

# pg_restore -U postgres -d dvdrental ./tmp/dvdrental.tar

# psql -U postgres -c "create role demouser"
# psql -U postgres -c "alter role demouser password 'demopw'"
# psql -U postgres -c "alter role demouser with login"
# psql -U postgres -c "grant all privileges on all tables in schema public to demouser"
# psql -U postgres -c "grant all privileges on database dvdrental to demouser"
# psql -U postgres -c "alter default privileges grant all on tables to demouser"
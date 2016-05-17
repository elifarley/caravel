#!/bin/bash

# Start Caravel
docker run --detach --name caravel \
    --env SECRET_KEY=mySUPERsecretKEY \
    --env SQLALCHEMY_DATABASE_URI="sqlite:////tmp/caravel.db" \
    --publish 8088:8088 \
    -v ~/caravel/caravel.db:/home/caravel/caravel.db \
    -v ~/caravel/odbc.ini:/home/caravel/.odbc.ini:ro \
    elifarley/caravel:MS-SQL

# Create an admin user
docker exec -it caravel fabmanager create-admin --app caravel

# Initialize the database
docker exec caravel caravel db upgrade

# Create default roles and permissions
docker exec caravel caravel init

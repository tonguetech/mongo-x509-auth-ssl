#!/usr/bin/env bash

read -s -p "Input MongoDB root username: " MONGODB_USERNAME
read -s -p "Input MongoDB root password: " MONGODB_PASSWORD
read -s -p "Input MongoDB listening port number: " MONGODB_PORT_NUM
docker run --name mongo-ssl -e MONGO_INITDB_ROOT_USERNAME=$MONGODB_USERNAME -e MONGO_INITDB_ROOT_PASSWORD=$MONGODB_PASSWORD -p $MONGODB_PORT_NUM:27017 -d mongo-ssl && docker logs mongo-ssl
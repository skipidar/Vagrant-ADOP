#!/bin/bash

# remove existing container
docker rm -f jenkins-slave-2

# create an own image
docker build --tag demo/jenkins-slave:latest -f ./dockerfile-jenkins-slave .

# start the slave using compose
docker-compose -f compose-jenkins-slave.yaml create
docker-compose -f compose-jenkins-slave.yaml start

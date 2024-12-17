#!/bin/bash

docker network inspect khc-logging-system-network >/dev/null 2>&1 || \
docker network create khc-logging-system-network

docker build -t b-airflow:latest . 

docker-compose -f docker-compose.shared.yml up airflow-init
docker-compose -f docker-compose.shared.yml up 
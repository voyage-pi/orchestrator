#!/bin/bash
chmod +x fetch-secrets.sh
./fetch-secrets.sh

docker volume rm orchestrator_mongo-data
docker volume create orchestrator_mongo-data
docker compose -f docker-compose.prod.yaml -f docker-compose.prod.override.yaml up --build -d

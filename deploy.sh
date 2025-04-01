#!/bin/bash
chmod +x fetch-secrets.sh
./fetch-secrets.sh

docker-compose -f docker-compose.prod.yaml -f docker-compose.prod.override.yaml up -d

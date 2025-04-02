#!/bin/bash

az login --identity

KEYVAULT_NAME="voyage-vault"

SECRETS=("MONGOPASSWORD" "GOOGLEMAPSAPIKEY")

cat ./config.env > .env



for SECRET_NAME in "${SECRETS[@]}"
do
  SECRET_VALUE=$(az keyvault secret show --name $SECRET_NAME --vault-name $KEYVAULT_NAME --query "value" -o tsv)
  echo "$SECRET_NAME=$SECRET_VALUE" >> .env
done

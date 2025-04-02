#!/bin/bash

az login --identity

KEYVAULT_NAME="voyage-vault"

SECRETS=("MONGOPASSWORD", "GOOGLEMAPSAPIKEY")



for SECRET_NAME in "${SECRETS[@]}"
do
  SECRET_VALUE=$(az keyvault secret show --vault-name $KEYVAULT_NAME --name $SECRET_NAME --query value -o tsv)
  echo "$SECRET_NAME=$SECRET_VALUE" >> .env
done

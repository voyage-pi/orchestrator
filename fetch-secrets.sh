#!/bin/bash
# fetch-secrets.sh

# Login using the VM's managed identity
az login --identity

# Define your Key Vault name
KEYVAULT_NAME="voyage-vault"

# Define the secrets you want to fetch
SECRETS=("MONGOPASSWORD", "GOOGLEMAPSAPIKEY")

# Create or overwrite the .env file
echo "# Generated from Azure Key Vault on $(date)" > .env

# Fetch each secret and add to .env file
for SECRET_NAME in "${SECRETS[@]}"
do
  SECRET_VALUE=$(az keyvault secret show --vault-name $KEYVAULT_NAME --name $SECRET_NAME --query value -o tsv)
  echo "$SECRET_NAME=$SECRET_VALUE" >> .env
done

echo "Secrets fetched successfully to .env file"

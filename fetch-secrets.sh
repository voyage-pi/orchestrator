#!/bin/bash

az login --identity

KEYVAULT_NAME="voyage-vault"

# Define secret names and their corresponding .env variable names
declare -A SECRET_MAPPINGS=(
  ["MONGOPASSWORD"]="MONGOPASSWORD"
  ["GOOGLEMAPSAPIKEY"]="GOOGLEMAPSAPIKEY"
  ["OPENAI"]="OPENAI"
  ["SUPABASESERVICEROLEKEY"]="SUPABASE_SERVICE_ROLE_KEY"
  ["SUPABASEKEY"]="SUPABASE_KEY"
)

cat ./config.env > .env

# Loop through the secret mappings
for SECRET_NAME in "${!SECRET_MAPPINGS[@]}"
do
  ENV_NAME="${SECRET_MAPPINGS[$SECRET_NAME]}"
  SECRET_VALUE=$(az keyvault secret show --name $SECRET_NAME --vault-name $KEYVAULT_NAME --query "value" -o tsv)
  echo "$ENV_NAME=$SECRET_VALUE" >> .env
done

SUPABASE_URL=$(grep "SUPABASE_URL" .env | cut -d '=' -f2-)

# Create frontend .env file with Vite environment variables
echo "# Frontend Environment Variables" > ./frontend/ui/.env
echo "VITE_APP_GOOGLE_MAPS_API_KEY=$(az keyvault secret show --name GOOGLEMAPSAPIKEY --vault-name $KEYVAULT_NAME --query "value" -o tsv)" >> ./frontend/ui/.env
echo "VITE_SUPABASE_URL=$SUPABASE_URL" >> ./frontend/ui/.env
echo "VITE_SUPABASE_ANON_KEY=$(az keyvault secret show --name SUPABASEKEY --vault-name $KEYVAULT_NAME --query "value" -o tsv)" >> ./frontend/ui/.env

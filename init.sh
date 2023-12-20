#!/bin/bash

clear
echo `date +%Y-%m-%d_%H:%M:%S` "Start check basic coreInit ---"

export TF_API_TOKEN=`cat .env | grep token | cut -d'=' -f2-`
export GOOGLE_APPLICATION_CREDENTIALS=`cat .env | grep google_application_credentials | cut -d'=' -f2-`
export PROJECT=`cat .env | grep project | cut -d'=' -f2-`

echo "Variables:"
echo $GOOGLE_APPLICATION_CREDENTIALS
echo $PROJECT

# change breakline from space to breakline to for in bash
echo > terraform/terraform.tfvars
IFS=$'\n'
for I in `cat .env | grep tfvars`;
do
  # split $I by tfvars_ and get the second part
  RESULT=`echo $I | cut -d'_' -f2-`
  echo $RESULT >> terraform/terraform.tfvars
done

if ! [ -x "$(command -v docker)" ]; then
  echo 'Error: docker is not installed.' >&2
  exit 1
fi

# Set GCP credentials
IFS=$'\n'
for KEY_FILE in `cat .env | grep google_application_credentials | cut -d'=' -f2-`
do
  # remove double quotes
  KEY_FILE=`echo $KEY_FILE | tr -d '"'`
  KEY_FILE=`echo $KEY_FILE | tr -d ' '`
  if [ -z "$KEY_FILE" ]; then
    echo 'Error: GCP credentials are not set in .env' >&2
    echo 'add line: google_application_credentials' >&2
    exit 1
  fi
  cat $KEY_FILE > terraform/credentials.json
done

cp crederntials.tfrc.json terraform/credentials.tfrc.json

#create provider.tf
# Carregar variáveis do arquivo .env
ORGANIZATION_NAME=$(grep organization_name .env | cut -d'=' -f2-)
WORKSPACE=$(grep workspace .env | cut -d'=' -f2-)

# Criar o conteúdo do provider.tf
PROVIDER_TEMPLATE="terraform {
  cloud {
    organization = $ORGANIZATION_NAME

    workspaces {
      name = $WORKSPACE
    }
  }
}"

# Escrever o conteúdo no arquivo provider.tf
echo "$PROVIDER_TEMPLATE" > terraform/provider.tf

# Check Terraform Cloud loggin enabled
if [ -z "$TF_API_TOKEN" ]; then
  echo 'Error: Terraform Cloud loggin is not enabled.' >&2
  exit 1
fi

# Check GCP credentials
if [ -z "$GOOGLE_APPLICATION_CREDENTIALS" ]; then
  echo 'Error: GCP credentials are not set.' >&2
  exit 1
fi

echo `date +%Y-%m-%d_%H:%M:%S` "Finish check basic coreInit ---"

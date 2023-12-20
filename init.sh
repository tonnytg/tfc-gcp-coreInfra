#!/bin/bash

clear
echo `date +%Y-%m-%d_%H:%M:%S` "Starting check basic coreInit"

# Check terraform installed
if ! [ -x "$(command -v terraform)" ]; then
  echo 'Error: terraform is not installed.' >&2
  exit 1
fi

# Check Terraform Cloud loggin enabled
if [ -z "$TF_CLI_CONFIG_FILE" ]; then
  echo 'Error: Terraform Cloud loggin is not enabled.' >&2
  exit 1
fi

# Check GCP credentials
if [ -z "$GOOGLE_APPLICATION_CREDENTIALS" ]; then
  echo 'Error: GCP credentials are not set.' >&2
  exit 1
fi

# Elastic Stack on GKE

## Requirements:
Google Cloud Platform:
- folder ID
- billing ID
- Service Account Key

Local machine:
- gcloud CLI
- kubectl CLI
- helm CLI
- git CLI
- terraform CLI

## Clone this repo

```
git clone
```

## Set environment variables:

```sh
export GOOGLE_APPLICATION_CREDENTIALS=<PATH_TO_SERVICE_ACCOUNT_KEY>
export TF_VAR_billing_account=<BILLING_ACCOUNT_ID>
export TF_VAR_folder_id=<FOLDER_ID>
```

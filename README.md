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

```sh
git clone https://github.com/froggologies/gcp-terraform-exp-elastic.git && cd gcp-terraform-exp-elastic
```

## Set environment variables:

```sh
export GOOGLE_APPLICATION_CREDENTIALS=<PATH_TO_SERVICE_ACCOUNT_KEY>
export TF_VAR_billing_account=<BILLING_ACCOUNT_ID>
export TF_VAR_folder_id=<FOLDER_ID>
```

## Provision resources

> Change the backend in `terraform/backend.tf` to your backend configuration or delete it if you want to use local backend.

Initialize Terraform:
```sh
terraform -chdir=terraform init
```

Apply Terraform:
```sh
terraform -chdir=terraform apply
# Apply complete! Resources: 18 added, 0 changed, 0 destroyed.
```

Make sure use that we use the correct context
```sh
kubectl config get-contexts
```

If not then get the cluster credentials:
```sh
gcloud container clusters get-credentials <cluster-name> --zone <zone-location> --project <project-id>
```

Create a new namespace
```sh
kubectl apply -f efk-namespace.yaml
```

## Elastic Cloud on Kubernetes

Install custom resource definitions:
```sh
kubectl create -f https://download.elastic.co/downloads/eck/2.11.1/crds.yaml
```

Install the operator with its RBAC rules:
```sh
kubectl apply -f https://download.elastic.co/downloads/eck/2.11.1/operator.yaml
```

Create an efk namespace:
```sh
kubectl apply -f efk-namespace.yaml
```

## Elasticsearch
```sh
kubectl apply -f ElasticSearch.yaml
```
```sh
kubectl get elasticsearch -n efk
```
```
NAME            HEALTH   NODES   VERSION   PHASE   AGE
elasticsearch   green    1       8.12.2    Ready   2m6s
```

## Kibana

```sh
kubectl apply -f Kibana.yaml
```
```sh
kubectl get kibana -n efk
```
```
NAME     HEALTH   NODES   VERSION   AGE
kibana   green    1       8.12.2    11m
```
```sh
kubectl get svc kibana-kb-http -n efk
```

https://EXTERNAL-IP:5601/

username: elastic

password:
```sh
kubectl get secret elasticsearch-es-elastic-user -o=jsonpath='{.data.elastic}' -n efk | base64 --decode; echo
```

![login](./img/SCR-20240320-kzvb.png)
![home](./img/SCR-20240320-ldgy.png)

# Fluent-bit

```sh
helm repo add fluent https://fluent.github.io/helm-charts
```
```sh
helm upgrade --install fluent-bit fluent/fluent-bit -n efk
```

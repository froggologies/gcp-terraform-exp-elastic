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

Get cluster credentials:
```sh
gcloud container clusters get-credentials <cluster-name> --zone <zone-location> --project <project-id>
```

## Elasticsearch
```sh
helm repo add elastic https://helm.elastic.co
```

```sh
curl -O https://raw.githubusercontent.com/elastic/helm-charts/master/elasticsearch/examples/minikube/values.yaml
```

```sh
helm install elasticsearch elastic/elasticsearch -f ./values.yaml
```

```
NAME: elasticsearch
LAST DEPLOYED: Tue Mar 19 12:03:28 2024
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Watch all cluster members come up.
  $ kubectl get pods --namespace=default -l app=elasticsearch-master -w
2. Retrieve elastic user's password.
  $ kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
3. Test cluster health using Helm test.
  $ helm --namespace=default test elasticsearch
```

```
NAME                     READY   STATUS    RESTARTS   AGE
elasticsearch-master-0   1/1     Running   0          5m35s
elasticsearch-master-1   1/1     Running   0          5m35s
elasticsearch-master-2   1/1     Running   0          5m35s
```

## Kibana

```sh
helm install kibana elastic/kibana
```
```
NAME: kibana
LAST DEPLOYED: Tue Mar 19 12:16:47 2024
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
1. Watch all containers come up.
  $ kubectl get pods --namespace=default -l release=kibana -w
2. Retrieve the elastic user's password.
  $ kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
3. Retrieve the kibana service account token.
  $ kubectl get secrets --namespace=default kibana-kibana-es-token -ojsonpath='{.data.token}' | base64 -d
```
```
NAME                            READY   STATUS    RESTARTS   AGE
kibana-kibana-b46d9c6df-9f5rl   1/1     Running   0          71s
```
```sh
kubectl port-forward deployment/kibana-kibana 5601
```
username: elastic

password:
```
kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
```
![login](./img/SCR-20240320-kzvb.png)
![home](./img/SCR-20240320-ldgy.png)

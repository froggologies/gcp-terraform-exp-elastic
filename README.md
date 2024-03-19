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

```
gcloud container clusters get-credentials <cluster-name> --zone <zone-location> --project <project-id>
```

```
helm repo add elastic https://helm.elastic.co
```

```
curl -O https://raw.githubusercontent.com/elastic/helm-charts/master/elasticsearch/examples/minikube/values.yaml
```

```
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

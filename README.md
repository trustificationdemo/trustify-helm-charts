# Deploying Trustify using Helm

## Minikube

Create a new cluster:

```bash
minikube start --cpus 8 --memory 24576 --disk-size 20gb --addons ingress,dashboard
```

Create a new namespace:

```bash
kubectl create ns trustify
```

Install the infrastructure services:

```bash
APP_DOMAIN=.$(minikube ip).nip.io
helm upgrade --install --dependency-update -n trustify infrastructure charts/trustify-infrastructure --values values-minikube.yaml --set-string keycloak.ingress.hostname=sso$APP_DOMAIN --set-string appDomain=$APP_DOMAIN
```

Then deploy the application:

```bash
APP_DOMAIN=.$(minikube ip).nip.io
helm upgrade --install -n trustify trustify charts/trustify --values values-minikube.yaml --set-string appDomain=$APP_DOMAIN
```

## Kind

Create a new cluster:

```bash
kind create cluster --config kind/config.yaml
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml
```

Create a new namespace:

```bash
kubectl create ns trustify
```

Install the infrastructure services:

```bash
APP_DOMAIN=.$(kubectl get node kind-control-plane -o jsonpath='{.status.addresses[?(@.type == "InternalIP")].address}' | awk '// { print $1 }').nip.io
helm upgrade --install --dependency-update -n trustify infrastructure charts/trustify-infrastructure --values values-minikube.yaml --set-string keycloak.ingress.hostname=sso$APP_DOMAIN --set-string appDomain=$APP_DOMAIN
helm upgrade --install -n trustify trustify charts/trustify --values values-minikube.yaml --set-string appDomain=$APP_DOMAIN
```

# infra

## Prerequisites
- terraform
- kubectl
- aws-cli
- argocd

## Running

### Kubernetes setup
1. Store AWS credentials and config in `~/.aws/`
2. Get LabRole ARN
```bash
aws iam get-role --role-name LabRole | grep Arn
```
3. Terraform init and apply
```bash
terraform -chdir=terraform init
terraform -chdir=terraform apply -var="aws_iam_role=your_lab_role_arn"
```
4. Check the cluster's name
```bash
aws eks list-clusters
```
5. Generate kubeconfig 
```bash
aws eks update-kubeconfig --name your_cluster_name
```
6. Verify connection via kubectl
```bash
kubectl get nodes
```

### ArgoCD setup
1. Create namespace
```bash
kubectl create namespace argocd
```
2. Install ArgoCD
```bash
kubectl -n argocd apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
3. Expose ArgoCD service
```bash
kubectl -n argocd port-forward svc/argocd-server 8080:443
```
4. Access ArgoCD UI
```bash
open http://localhost:8080
```
5. Obtain the initial password
```bash
argocd admin initial-password -n argocd
```
6. Login
```bash
argocd login localhost:8080 --username admin --password your_initial_password
```

### Argo Workflows setup
1. Create namespace
```bash
kubectl create namespace argo
```
2. Install Argo Workflows
```bash
kubectl -n argo apply -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.7/quick-start-minimal.yaml
```
3. Apply patch to Argo Workflows deployment
```bash
kubectl -n argo patch deployment argo-server --type JSON --patch-file k8s/argo-server-patch.yaml
```
4. Expose Argo Workflows service
```bash
kubectl -n argo port-forward svc/argo-server 2746:2746
```
5. Access Argo Workflows UI
```bash
open http://localhost:2746
```

### Setup workflow-api application
1. Create namespace
```bash
kubectl config set-context --current --namespace=argocd
```
2. Create application in ArgoCD from repository
```bash
argocd app create workflow-api --repo https://github.com/SUU-Argo/workflow-api.git --path deploy --dest-server https://kubernetes.default.svc --dest-namespace argo
```
3. Display application instance details
```bash
argocd app get workflow-api
```
4. Enable automatic sync
```bash
argocd app set workflow-api --sync-policy automated
```
5. Expose workflow-api application
```bash
kubectl -n argo port-forward svc/workflow-api 8081:8080
```
6. Access workflow-api application
```bash
open http://localhost:8081
```

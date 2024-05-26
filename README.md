# infra

## Prerequisites
- terraform
- kubectl
- aws-cli
- argocd

## Running
### Kubernetes setup
1. Store AWS credentials and config in ~/.aws/
2. `terraform init`
3. `terraform apply`
4. Check the cluster's name: `aws eks list-clusters `
5. Generate kubeconfig: `aws eks update-kubeconfig --name <your cluster>`
6. Verify connection via kubectl: `kubectl get nodes`

### ArgoCD setup
1. Create namespace: `kubectl create namespace argocd`
2. Install ArgoCD: `kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml`
3. Make Argo API accessible from the local machine (makes the terminal busy): `kubectl port-forward svc/argocd-server -n argocd 8080:443`
4. Access Argo API via web browser: [localhost:8080](https://localhost:8080)
5. Obtain the password: `argocd admin initial-password -n argocd` and login via web browser, the login is `admin`

### Create application from Git repository
1. Set namespace: `kubectl config set-context --current --namespace=argocd`
2. Create sample application: `argocd app create guestbook --repo https://github.com/SUU-Argo/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default`
3. 

## Sources
- https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks
- https://github.com/hashicorp/learn-terraform-provision-eks-cluster
- https://argo-cd.readthedocs.io/en/stable/getting_started/

# infra
## Prerequisites
- terraform
- kubectl
- aws-cli

## Running
### Kubernetes setup
1. Store AWS credentials and config in ~/.aws/
2. `cd terraform`
2. `terraform init`
3. `terraform apply`
4. Check the cluster's name: `aws eks list-clusters `
5. Generate kubeconfig: `aws eks update-kubeconfig --name <your cluster>`
6. Verify connection via kubectl: `kubectl get nodes`

## Sources
- https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks
- https://github.com/hashicorp/learn-terraform-provision-eks-cluster

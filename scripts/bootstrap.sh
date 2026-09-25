#!/bin/bash

set -e


if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
fi

ssh-add ~/.ssh/homelab_ed25519

#infra automation
cd terraform

terraform init
terraform plan -var-file=terraform.tfvars -out=tfplan
terraform apply tfplan

server_ip=$(terraform output -raw k3s_server_ip)

cd ..


cd ansible

ansible k3s_cluster \
  -m ansible.builtin.wait_for_connection \
  -a "timeout=300 sleep=5"

ansible-playbook playbooks/site.yml

ansible k3s_server \
  -b \
  -m ansible.builtin.fetch \
  -a "src=/etc/rancher/k3s/k3s.yaml dest=/tmp/k3s.yaml flat=yes"

cd ..

#configure kubeconfig
sed -i "s|127.0.0.1|$server_ip|" /tmp/k3s.yaml

mkdir -p ~/.kube
mv /tmp/k3s.yaml ~/.kube/config

#start argo cd
helm repo add argo https://argoproj.github.io/argo-helm --force-update
helm repo update

helm upgrade --install argocd argo/argo-cd \
  --version 10.4.0 \
  --namespace argocd \
  --create-namespace \
  --wait \
  --timeout 5m \
  -f kubernetes/argocd/values.yml

#connect argo cd to repo
kubectl create secret generic automated-homelab-repo \
  --namespace argocd \
  --from-literal=type=git \
  --from-literal=url=git@github.com:yomtra/automated-homelab.git \
  --from-file=sshPrivateKey="$HOME/.ssh/argocd_github" \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl label secret automated-homelab-repo \
  --namespace argocd \
  argocd.argoproj.io/secret-type=repository \
  --overwrite

#deploy applications
kubectl apply -f kubernetes/argocd/root.yml
# Automated Homelab

The goal of this project was to automate the creation of a homelab instead of configuring everything manually. **Terraform** provisions the virtual machines on **Proxmox**, **Ansible** configure the virtual machines and creates the **Kubernetes** cluster, and **ArgoCD** deploys and manages the applications through **GitOps**. 


The project is deployed through `scripts/bootstrap.sh`.


Terraform first creates the infrastructure and generates the Ansible inventory. Ansible then configures the VMs and installs K3s.

After the cluster is created, the script retrieves the kubeconfig, installs Argo CD, configures access to the repository, and applies the root Argo CD application.

Argo CD then takes over application deployment.

## Components

| Component | Description |
| --------- | ----------- |
| **Proxmox** | Hosts the virtual machines used by the K3s cluster |
| **Terraform** | Creates the Ubuntu template, VMs, networking, and Ansible inventory |
| **Ansible** | Configures the VMs and installs the K3s control plane and worker |
| **K3s** | Runs the Kubernetes cluster |
| **Argo CD** | Deploys and manages applications from GitHub |
| **Helm** | Used by Argo CD to deploy application charts |


<img width="726" height="1109" alt="image" src="https://github.com/user-attachments/assets/d3b89732-08a0-42c0-b5ad-129ab99fc1e4" />

## Prerequisites

Have Proxmox installed on a machine, configure a Terraform API token, and make sure root SSH access is available for Terraform to upload the cloud-init network snippets.

Have Terraform, Ansible, kubectl and Helm installed on the machine running the bootstrap script.

Before deploying, make sure the `local` Proxmox storage allows snippets and that your VM storage is configured correctly.

### Deploying:
Make sure `terraform.tfvars` is filled out, then run `scripts/bootstrap.sh`



## Applications

The applications I chose to showcase were Argo CD, Headlamp, Pi-hole and the Prometheus/Grafana monitoring stack.

Argo CD handles GitOps, Headlamp gives me a GUI for the Kubernetes cluster, Pi-hole acts as a DNS server which allows network-wide ad blocking, and Prometheus/Grafana provide metrics on the health and resource usage of the cluster.

The cluster can also be used to run other workloads such as game servers, media applications, and other self-hosted services.

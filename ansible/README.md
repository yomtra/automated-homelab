# Ansible

This directory handles configuration of the virtual machines after they are created by Terraform. Ansible configures DNS, installs K3s, and joins the worker node to the cluster.


## Playbook

The main playbook is `site.yml`, it runs these three roles:

| Role | Description |
| ---- | ----------- |
| **k3s_server** | installs the K3s control plane and waits for the Kubernetes API server to become available |
| **k3s_agent** | retrieves the cluster token from the control node and uses it to join the worker to the cluster |
| **k3s_cluster** | Installs required packages, starts the QEMU guest agent, and configures DNS |

These roles remove the need to manually copy tokens or configure the worker after the control plane is created.

## Inventory

Terraform automatically generates `inventory/inventory.ini`

The inventory contains three groups:

| Group | Description |
| ----- | ----------- |
| `k3s_server` | K3s control-plane nodes |
| `k3s_agent` | K3s worker nodes |
| `k3s_cluster` | Both groups combined |

The inventory allows the same playbook to apply common configuration to every node while still running control-plane and worker-specific tasks separately.

## DNS Configuration

The DNS servers for each VM are originally configured by Terraform through cloud-init. 

However, Ubuntu defaults to using its own local DNS resolver instead, which blocked K3s from pulling container images. To fix this, Ansible points the system directly to the correct cloud-init DNS resolvers, allowing image downloads to work properly.

## K3s Cluster

The control plane is installed first. Ansible then retrieves the K3s join token from the control node and uses it to join the worker node automatically.

Once both nodes are part of the cluster, the bootstrap script retrieves the kubeconfig and moves on to installing Argo CD.
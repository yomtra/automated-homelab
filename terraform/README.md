# Terraform

This directory handles the infrastructure portion of the homelab.

Terraform downloads an Ubuntu cloud image, creates a reusable Proxmox template, clones the virtual machines, configures their networking, and generates the inventory used by Ansible.

## Modules

| Module | Description |
| ------ | ----------- |
| **proxmox-template** | Downloads the Ubuntu cloud image and creates the Proxmox VM template |
| **proxmox-vm** | Clones VMs from the template and configures resources, networking, and SSH access |

The template provides a reusable base image instead of creating each VM from scratch. The `proxmox-vm` module can then be reused for each node defined in `terraform.tfvars`.

The current cluster contains two virtual machines:

| VM | Role |
| -- | ---- |
| `k3s-control` | Kubernetes control plane |
| `k3s-worker` | Kubernetes worker |

## Networking

Terraform creates the network configuration for each VM using cloud-init.

Cloud-init applies the network configuration when the VMs are first booted, removing the need to ssh in and configure networking manually.

Each VM is connected to the Proxmox network bridge and is given:

- A static IPv4 address
- A default gateway
- DNS servers
- The `homelab.local` search domain

DHCP and IPv6 are disabled for the VM so the cluster nodes keep the same IPv4 addresses between rebuilds.
## Ansible Inventory

Terraform generates `ansible/inventory/inventory.ini`


The VMs are automatically placed into either the `k3s_server` or `k3s_agent` group based on their configured role.

This allows the vms created by Terraform to immediately be used by Ansible in the next step of the automation.

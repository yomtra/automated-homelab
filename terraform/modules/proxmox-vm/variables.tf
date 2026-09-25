variable "node_name" {
  description = "Name of the Proxmox node that hosts the VM."
  type        = string
}

variable "template_vm_id" {
  description = "VM ID of the source template."
  type        = number
}

variable "vm_id" {
  description = "Numeric Proxmox VM ID assigned to the clone."
  type        = number
}

variable "vm_name" {
  description = "Name assigned to the cloned VM."
  type        = string
}

variable "cpu_cores" {
  description = "Number of CPU cores assigned to the VM."
  type        = number
}

variable "memory_mb" {
  description = "Dedicated VM memory in megabytes."
  type        = number
}

variable "datastore_id" {
  description = "Datastore used for the cloned disk and cloud-init drive."
  type        = string
}

variable "network_bridge" {
  description = "Proxmox network bridge attached to the VM."
  type        = string
}

variable "network_model" {
  description = "Virtual network adapter model."
  type        = string
}

variable "ipv4_address" {
  description = "Static IPv4 address in CIDR notation."
  type        = string
}

variable "ipv4_gateway" {
  description = "Default IPv4 gateway configured through cloud-init."
  type        = string
}

variable "dns_servers" {
  description = "DNS server addresses configured through cloud-init."
  type        = list(string)
}

variable "cloud_init_user" {
  description = "Login username created through cloud-init."
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key content injected through cloud-init."
  type        = string
}

variable "snippets_datastore_id" {
  type    = string
  default = "local"
}
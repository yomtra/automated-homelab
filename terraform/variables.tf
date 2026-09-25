variable "proxmox_endpoint" {
  description = "Proxmox VE API endpoint."
  type        = string
}

variable "terraform_api_token" {
  description = "Proxmox API token."
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Whether to skip TLS certificate verification for the Proxmox API."
  type        = bool
}

variable "proxmox_node_name" {
  description = "Name of the Proxmox node that hosts the template and VMs."
  type        = string
}

variable "template_name" {
  description = "Name of the Ubuntu cloud-image template."
  type        = string
}

variable "template_vm_id" {
  description = "Numeric Proxmox VM ID assigned to the template."
  type        = number
}

variable "datastore_id" {
  description = "Datastore used for VM disks and cloud-init drives."
  type        = string
}

variable "download_datastore_id" {
  description = "File-based datastore used to download the cloud image."
  type        = string
}

variable "template_disk_size" {
  description = "Template boot disk size in gigabytes."
  type        = number
}

variable "template_memory_mb" {
  description = "Dedicated memory assigned to the template in megabytes."
  type        = number
}

variable "template_cpu_cores" {
  description = "CPU cores assigned to the template VM."
  type        = number
}

variable "template_machine_type" {
  description = "QEMU machine type used by the template VM."
  type        = string
}

variable "template_bios_type" {
  description = "Firmware implementation used by the template VM."
  type        = string
}

variable "template_efi_disk_type" {
  description = "OVMF EFI variables disk type for the template VM."
  type        = string
}

variable "template_disk_interface" {
  description = "Disk interface used for the imported template disk."
  type        = string
}

variable "template_scsi_hardware" {
  description = "SCSI controller model used by the template VM."
  type        = string
}

variable "network_bridge" {
  description = "Proxmox network bridge attached to the VMs."
  type        = string
}

variable "template_network_model" {
  description = "Virtual network adapter model used by the template VM."
  type        = string
}

variable "vm_network_model" {
  description = "Virtual network adapter model used by cloned VMs."
  type        = string
}

variable "template_image_file_name" {
  description = "Cloud image filename stored on the download datastore."
  type        = string
}

variable "vm_image_url" {
  description = "URL of the Ubuntu cloud image to download."
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

variable "ssh_public_key_path" {
  description = "Path to the SSH public key injected into VMs."
  type        = string
  sensitive   = true
}

variable "vms" {
  description = "Map of VMs to clone from the Ubuntu template."
  type = map(object({
    vm_id        = number
    name         = string
    role         = string
    cpu_cores    = number
    memory_mb    = number
    ipv4_address = string
  }))
}

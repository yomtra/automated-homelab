variable "node_name" {
  description = "Name of the Proxmox node that hosts the template."
  type        = string
}

variable "template_name" {
  description = "Name assigned to the template VM."
  type        = string
}

variable "template_vm_id" {
  description = "Numeric Proxmox VM ID assigned to the template."
  type        = number
}

variable "datastore_id" {
  description = "Datastore used for the template disk, EFI disk, and cloud-init drive."
  type        = string
}

variable "download_datastore_id" {
  description = "File-based datastore used to download the cloud image."
  type        = string
}

variable "cpu_cores" {
  description = "Number of CPU cores assigned to the template."
  type        = number
}

variable "memory_mb" {
  description = "Dedicated template memory in megabytes."
  type        = number
}

variable "machine_type" {
  description = "QEMU machine type used by the template."
  type        = string
}

variable "bios_type" {
  description = "Firmware implementation used by the template."
  type        = string
}

variable "efi_disk_type" {
  description = "OVMF EFI variables disk type."
  type        = string
}

variable "disk_size" {
  description = "Template boot disk size in gigabytes."
  type        = number
}

variable "disk_interface" {
  description = "Interface used for the imported template disk."
  type        = string
}

variable "scsi_hardware" {
  description = "SCSI controller model used by the template."
  type        = string
}

variable "network_bridge" {
  description = "Proxmox network bridge attached to the template."
  type        = string
}

variable "network_model" {
  description = "Virtual network adapter model."
  type        = string
}

variable "template_image_file_name" {
  description = "Filename used for the downloaded cloud image."
  type        = string
}

variable "vm_image_url" {
  description = "URL of the cloud image to download."
  type        = string
}

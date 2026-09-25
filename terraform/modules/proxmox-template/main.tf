resource "proxmox_virtual_environment_vm" "template" {
  name      = var.template_name
  node_name = var.node_name
  vm_id     = var.template_vm_id

  template = true
  started  = false
  on_boot  = false

  machine       = var.machine_type
  bios          = var.bios_type
  scsi_hardware = var.scsi_hardware

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory_mb
  }

  efi_disk {
    datastore_id = var.datastore_id
    type         = var.efi_disk_type
  }

  disk {
    datastore_id = var.datastore_id
    import_from  = proxmox_download_file.image.id
    interface    = var.disk_interface
    discard      = "on"
    size         = var.disk_size
  }

  initialization {
    datastore_id = var.datastore_id

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  network_device {
    bridge = var.network_bridge
    model  = var.network_model
  }

  agent {
    enabled = true
  }

  stop_on_destroy = true
}

resource "proxmox_download_file" "image" {
  content_type = "import"
  datastore_id = var.download_datastore_id
  file_name    = var.template_image_file_name
  node_name    = var.node_name
  url          = var.vm_image_url
}

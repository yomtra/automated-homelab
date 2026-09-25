resource "proxmox_virtual_environment_vm" "clone" {
  node_name = var.node_name
  name      = var.vm_name
  vm_id     = var.vm_id

  started  = true
  on_boot  = false
  template = false

  agent {
    enabled = true

    wait_for_ip {
      disabled = true
    }
  }

  clone {
    vm_id        = var.template_vm_id
    full         = true
    datastore_id = var.datastore_id
  }

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory_mb
  }

  initialization {
    datastore_id = var.datastore_id
    network_data_file_id = proxmox_virtual_environment_file.network_config.id

    user_account {
      username = var.cloud_init_user
      keys     = [var.ssh_public_key]
    }
  }

  network_device {
    bridge = var.network_bridge
    model  = var.network_model
  }

  stop_on_destroy = true
}

resource "proxmox_virtual_environment_file" "network_config" {
  content_type = "snippets"
  datastore_id = var.snippets_datastore_id
  node_name    = var.node_name

  source_raw {
    data = templatefile("${path.module}/network-config.tpl", {
      ipv4_address = var.ipv4_address
      ipv4_gateway = var.ipv4_gateway
      dns_servers  = var.dns_servers
    })
    file_name = "${var.vm_name}-network-config.yaml"
  }
}

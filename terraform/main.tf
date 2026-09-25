module "proxmox_template" {
  source = "./modules/proxmox-template"

  node_name                = var.proxmox_node_name
  template_name            = var.template_name
  template_vm_id           = var.template_vm_id
  datastore_id             = var.datastore_id
  download_datastore_id    = var.download_datastore_id
  disk_size                = var.template_disk_size
  memory_mb                = var.template_memory_mb
  cpu_cores                = var.template_cpu_cores
  machine_type             = var.template_machine_type
  bios_type                = var.template_bios_type
  efi_disk_type            = var.template_efi_disk_type
  disk_interface           = var.template_disk_interface
  scsi_hardware            = var.template_scsi_hardware
  network_bridge           = var.network_bridge
  network_model            = var.template_network_model
  template_image_file_name = var.template_image_file_name
  vm_image_url             = var.vm_image_url
}

module "proxmox_vm" {
  source   = "./modules/proxmox-vm"
  for_each = var.vms

  node_name       = var.proxmox_node_name
  template_vm_id  = module.proxmox_template.vm_id
  vm_id           = each.value.vm_id
  vm_name         = each.value.name
  cpu_cores       = each.value.cpu_cores
  memory_mb       = each.value.memory_mb
  datastore_id    = var.datastore_id
  network_bridge  = var.network_bridge
  network_model   = var.vm_network_model
  ipv4_address    = each.value.ipv4_address
  ipv4_gateway    = var.ipv4_gateway
  dns_servers     = var.dns_servers
  cloud_init_user = var.cloud_init_user
  ssh_public_key  = local.ssh_public_key
}

resource "local_file" "ansible_inventory" {
  filename        = "../ansible/inventory/inventory.ini"
  file_permission = "0644"

  content = templatefile(
    "${path.module}/inventory.tpl",
    {
      vms = {
        for name, vm in module.proxmox_vm : name => {
          ip   = split("/", vm.ipv4_address)[0]
          role = var.vms[name].role
        }
      }
      cloud_init_user = var.cloud_init_user
    }
  )
}

locals {
  ssh_public_key = trimspace(file(var.ssh_public_key_path))
}

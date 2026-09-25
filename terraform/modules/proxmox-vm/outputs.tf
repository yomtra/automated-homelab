output "vm_id" {
  value = proxmox_virtual_environment_vm.clone.vm_id
}

output "name" {
  value = proxmox_virtual_environment_vm.clone.name
}

output "ipv4_address" {
  value = var.ipv4_address
}
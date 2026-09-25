output "template_vm_id" {
  value = module.proxmox_template.vm_id
}

output "k3s_server_ip" {
  value = [
    for name, vm in module.proxmox_vm : split("/", vm.ipv4_address)[0]
    if var.vms[name].role == "control"
  ][0]
}

output "vm_ids" {
  value = {
    for name, clone in module.proxmox_vm : name => clone.vm_id
  }
}

output "vm_ips" {
  value = {
    for name, clone in module.proxmox_vm : name => clone.ipv4_address
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.terraform_api_token
  insecure  = var.proxmox_insecure

  ssh {
    username = "root"
    agent    = true
  }
}

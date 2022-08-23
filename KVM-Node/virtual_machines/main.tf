provider "proxmox" {
  pm_api_url  = "https://10.0.0.140:8006/api2/json"
  pm_user     = "terraform-prov@pve"
  pm_password = ""
  pm_debug    = true
}

resource "proxmox_vm_qemu" "example" {
  count       = 3
  name        = "KVM-Node-${count.index}"
  vmid        = 300 + count.index
  target_node = "pve1"
  pool        = "Class"
  clone       = "KVM-Node-Template"
  full_clone  = true
  desc        = "KVM Node for OpenNebula"
  cores       = 8
  sockets     = 1
  cpu         = "host"
  memory      = 10240
  scsihw      = "virtio-scsi-single"
  bootdisk    = "scsi0"
  agent       = 1
  onboot      = false

  network {
    model    = "virtio"
    bridge   = "vmbr0"
    macaddr  = var.mac_list[count.index]
    firewall = true
  }
  disk {
    type    = "scsi"
    size    = "100G"
    storage = "datapool"
    format  = "raw"
  }
}

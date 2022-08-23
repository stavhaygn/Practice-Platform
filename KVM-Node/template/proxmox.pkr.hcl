variable "host" {
  type = string
}

variable "skip_tls_verify" {
  type    = bool
  default = true
}

variable "username" {
  type    = string
  default = "root@pam"
}

variable "password" {
  type = string
}

variable "node" {
  type    = string
  default = "pve1"
}

variable "vm_pool" {
  type = string
}

variable "disk_storage_pool" {
  type = string
}

variable "disk_storage_type" {
  type    = string
  default = "lvm"
}

source "proxmox-iso" "autogenerated_1" {
  proxmox_url              = "https://${var.host}:8006/api2/json"
  insecure_skip_tls_verify = "${var.skip_tls_verify}"
  username                 = "${var.username}"
  password                 = "${var.password}"
  node                     = "${var.node}"
  pool                     = "${var.vm_pool}"
  vm_id                    = 333
  vm_name                  = "debian-11.4.0-amd64"
  template_description     = "KVM node template for OpenNebula. Built on ${legacy_isotime("2006-01-02T15:04:05Z")}"
  template_name            = "KVM-Node-Template"
  iso_file                 = "local:iso/debian-11.4.0-amd64-netinst.iso"
  os                       = "l26"
  cores                    = "2"
  sockets                  = 1
  cpu_type                 = "host"
  memory                   = 2048

  network_adapters {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = true
  }

  scsi_controller = "virtio-scsi-single"
  disks {
    type              = "scsi"
    disk_size         = "100G"
    storage_pool      = "${var.disk_storage_pool}"
    storage_pool_type = "${var.disk_storage_type}"
    format            = "raw"
    io_thread         = true
  }
  
  http_directory = "http"
  boot           = "order=scsi0;ide2"
  boot_command   = ["<esc><wait>", "auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
  boot_wait      = "10s"
  unmount_iso    = true
  ssh_timeout    = "10000s"
  ssh_password   = "packer"
  ssh_username   = "packer"
  qemu_agent     = true
}

build {
  sources = ["sources.proxmox-iso.autogenerated_1"]
  // provisioner "ansible" {
  //   playbook_file = "./install_dependencies.yml"
  //   extra_arguments = ["--extra-vars", "ansible_sudo_pass=packer"]
  // }
}

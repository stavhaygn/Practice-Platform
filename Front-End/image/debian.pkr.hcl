source "qemu" "example" {
  iso_url          = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.4.0-amd64-netinst.iso"
  iso_checksum     = "d490a35d36030592839f24e468a5b818c919943967012037d6ab3d65d030ef7f"
  headless         = true
  output_directory = "output"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  memory           = 1024
  disk_size        = "8192M"
  format           = "qcow2"
  accelerator      = "kvm"
  http_directory   = "http"
  ssh_username     = "packer"
  ssh_password     = "packer"
  ssh_timeout      = "20m"
  vm_name          = "Debian11"
  net_device       = "virtio-net"
  disk_interface   = "scsi" // for d-i grub-installer/bootdev  string /dev/sda
  boot_wait        = "10s"
  boot_command     = ["<esc><wait>", "auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
}

build {
  sources = ["source.qemu.example"]
  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'" // https://www.packer.io/docs/provisioners/shell#sudo-example
    scripts = [
      "scripts/install_docker.sh",
      "scripts/install_docker_compose.sh",
      "scripts/setup.sh"
    ]
  }
}
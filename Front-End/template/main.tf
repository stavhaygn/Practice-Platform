provider "opennebula" {
  endpoint = var.api_url
  username = var.teacher.username
  password = var.teacher.password
}

data "opennebula_group" "class" {
  name = var.class.name
  tags = {
    "type" = name
  }
}

data "opennebula_image" "debian" {
  name = "Debian11"
}

resource "opennebula_template" "debian" {
  name        = "Debian for students"
  description = "VM template"
  cpu         = 1
  vcpu        = 1
  memory      = 1024
  group       = data.opennebula_group.class.name
  permissions = "640"

  context = {
    NETWORK = "yes"
  }

  graphics {
    type   = "VNC"
    listen = "0.0.0.0"
  }

  os {
    arch = "x86_64"
    boot = "disk0"
  }

  disk {
    image_id = data.opennebula_image.debian.id
    size     = 8192
  }

  tags = {
    "type" = "material"
  }
}

provider "opennebula" {
  endpoint = var.api_url
  username = var.admin.username
  password = var.admin.password
}

data "opennebula_group" "class" {
  name = var.class.name
  tags = {
    "type" = name
  }
}

resource "opennebula_virtual_network" "example" {
  name            = "virtual-network"
  permissions     = "744"
  group           = data.opennebula_group.class.name
  bridge          = "br0"
  physical_device = "enp0s18"
  type            = "bridge"
  mtu             = 1500
  gateway         = "10.0.0.1"
  network_mask    = "255.255.255.0"
  dns             = "10.0.0.1"
  security_groups = []
  clusters        = [0]

  ar {
    ar_type = "IP4"
    size    = 16
    ip4     = "10.0.0.101"
  }

  tags = {
    "type" = "class"
  }
}

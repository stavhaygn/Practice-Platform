provider "opennebula" {
  endpoint = var.api_url
  username = var.admin.username
  password = var.admin.password
}

data "opennebula_group" "oneadmin" {
  name = "oneadmin"
}

data "opennebula_group" "users" {
  name = "users"
}

resource "opennebula_group" "class" {
  name = var.class.name
  tags = {
    "type" = name
  }
}

resource "opennebula_user" "teacher" {
  name          = var.teacher.username
  password      = var.teacher.password
  auth_driver   = "core"
  primary_group = opennebula_group.class.id
  groups        = [opennebula_group.class.id, data.opennebula_group.oneadmin.id]

  quotas {
    vm_quotas {
      running_vms      = 4
      running_cpu      = 8
      running_memory   = 8192
      vms              = 4
      cpu              = 8
      memory           = 8192
      system_disk_size = 40960
    }
  }

  depends_on = [
    opennebula_group.class
  ]
}

resource "opennebula_user" "students" {
  for_each      = { for username, password in var.students : username => password }
  name          = each.value.username
  password      = each.value.password
  auth_driver   = "core"
  primary_group = opennebula_group.class.id
  groups        = [opennebula_group.class.id, data.opennebula_group.users.id]

  quotas {
    vm_quotas {
      running_vms      = 1
      running_cpu      = 1
      running_memory   = 1024
      vms              = 1
      cpu              = 1
      memory           = 1024
      system_disk_size = 10240
    }
  }

  depends_on = [
    opennebula_group.class
  ]
}

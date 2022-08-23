variable "api_url" {
  type    = string
  default = "http://127.0.0.1:2633/RPC2"
}

variable "admin" {
  type = object({
    username = string
    password = string
  })
  default = {
    username = "oneadmin"
    password = "changeme123"
  }
}

variable "class" {
  type = object({
    name = string
  })
  default = {
    name = "class"
  }
}

variable "teacher" {
  type = object({
    username = string
    password = string
  })
  default = {
    password = "teacher"
    username = "teacher"
  }
}

variable "students" {
  type = list(object({
    username = string
    password = string
  }))
  default = [
    {
      username = "student01"
      password = "password01"
    }
  ]
}

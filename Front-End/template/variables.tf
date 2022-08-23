variable "api_url" {
  type    = string
  default = "http://127.0.0.1:2633/RPC2"
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

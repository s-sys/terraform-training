variable "instances" {
  type = list(object({
    name          = string
    internal_port = number
    external_port = number
  }))
}

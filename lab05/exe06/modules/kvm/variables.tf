variable "vms" {
  type = list(object({
    name   = string
    memory = number
    vcpu   = number
  }))
}

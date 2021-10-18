output "ips" {
  value = libvirt_domain.vm.network_interface[*].addresses
}

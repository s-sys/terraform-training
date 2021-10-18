output "ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "username" {
  value = var.admin_username
}

output "password" {
  value     = var.admin_password
  sensitive = true
}

output "ssh_command" {
  value = "ssh ${var.admin_username}@${azurerm_public_ip.public_ip.ip_address}"
}

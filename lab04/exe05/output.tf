output "password" {
  value     = "Password: ${module.mysql.password}"
  sensitive = true
}

output "user" {
  value     = "Username: ${module.mysql.user}"
}

output "database" {
  value     = "Database: ${module.mysql.database}"
}

output "password" {
  value     = "Password: ${module.mysql.password}"
  sensitive = true
}

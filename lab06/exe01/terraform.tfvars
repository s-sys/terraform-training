subscription_id = ""
tenant_id       = ""
client_id       = ""
client_secret   = ""

resource_group  = "terraform-rg-student-01"
location        = "centralus"
admin_username  = "azureroot"
admin_password  = "Passw0rd123"

rules = [
  {
    name      = "SSH"
    protocol  = "Tcp"
    port      = 22
  },
  {
    name      = "HTTP"
    protocol  = "Tcp"
    port      = 80
  },
  {
    name      = "HTTPS"
    protocol  = "Tcp"
    port      = 443
  },
  {
    name      = "My-API"
    protocol  = "Tcp"
    port      = 8081
  },
]

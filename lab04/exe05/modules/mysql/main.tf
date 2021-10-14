terraform {
  required_providers {
    mysql = {
      source  = "winebarrel/mysql"
      version = "~> 1.10.6"
    }
  }
  required_version = ">= 0.13"
}

provider "mysql" {
  endpoint = "192.168.1.13"
  username = "root"
  password = "linux"
}

resource "mysql_database" "database" {
  name = var.database
}

resource "random_password" "password" {
  length  = 10
  special = false
}

resource "mysql_user" "user" {
  user               = var.user
  host               = "%"
  plaintext_password = random_password.password.result
}

resource "mysql_grant" "grant" {
  user       = mysql_user.user.user
  host       = mysql_user.user.host
  database   = mysql_database.database.name
  privileges = ["ALL"]
  grant      = false
}

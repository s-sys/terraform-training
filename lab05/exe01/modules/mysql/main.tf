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

locals {
  db_name  = (
               upper(substr(var.database, 0, 3)) == "DB-"
               ? substr(upper(var.database), 0, 14)
               : substr(upper("DB-${var.database}"), 0, 14)
             )
  user     = (
               lower(substr(var.user, 0, 2)) == "u-"
               ? replace(substr(lower(var.user), 0, 14), " ", "_")
               : replace(substr(lower("u-${var.user}"), 0, 14), " ", "_")
             )
  password = random_password.password.result
}

resource "mysql_database" "database" {
  name = local.db_name
}

resource "random_password" "password" {
  length      = 10
  min_lower   = 1
  min_numeric = 1
  min_upper   = 1
  lower   = true
  upper   = true
  numeric = true
  special = false
}

resource "mysql_user" "user" {
  user               = local.user
  host               = "%"
  plaintext_password = local.password
}

resource "mysql_grant" "grant" {
  user       = mysql_user.user.user
  host       = mysql_user.user.host
  database   = mysql_database.database.name
  privileges = ["ALL"]
  grant      = false
}

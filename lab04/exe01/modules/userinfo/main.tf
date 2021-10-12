resource "null_resource" "userinfo" {
  triggers = {
    username = var.username
  }

  provisioner "local-exec" {
    when    = create
    command = "echo ${var.username} > result-${var.username}.txt"
  }

  provisioner "local-exec" {
    when    = create
    command = "echo ${var.full_name} >> result-${var.username}.txt"
  }

  provisioner "local-exec" {
    when    = create
    command = "echo ${var.address} >> result-${var.username}.txt"
  }

  provisioner "local-exec" {
    when    = create
    command = "echo ${var.city} >> result-${var.username}.txt"
  }

  provisioner "local-exec" {
    when    = create
    command = "echo ${var.state} >> result-${var.username}.txt"
  }

  provisioner "local-exec" {
    when    = create
    command = "echo ${var.zip} >> result-${var.username}.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f result-${self.triggers.username}.txt"
  }
}

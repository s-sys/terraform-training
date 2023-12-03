terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "~> 0.7.6"
    }
  }
 required_version = ">= 1.6"
}

provider "libvirt" {
  uri = "qemu:///system"
}

locals {
  instances = [for i in var.vms : (substr(i.name, 0, 2) == "t-" ? i.name : "t-${i.name}")]
  num_vms   = length(local.instances)
}

resource "libvirt_volume" "volume" {
  count  = local.num_vms 
  name   = "${local.instances[count.index]}.qcow2"
  source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
  pool   = "VMs"
  format = "qcow2"
}

data "template_file" "user_data" {
  count    = length(local.instances)
  template = file("${path.module}/cloud_init.cfg")

  vars = {
    hostname = local.instances[count.index] 
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  count          = local.num_vms
  name           = "cloudinit-${local.instances[count.index]}.iso"
  user_data      = data.template_file.user_data[count.index].rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_volume.volume[count.index].pool
}

resource "libvirt_domain" "vm" {
  count      = local.num_vms
  name       = local.instances[count.index]
  memory     = var.vms[count.index].memory == null ? 640 : var.vms[count.index].memory
  vcpu       = var.vms[count.index].vcpu   == null ? 2   : var.vms[count.index].vcpu
  cloudinit  = libvirt_cloudinit_disk.cloudinit[count.index].id

  cpu {
    mode = "host-model"
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.volume[count.index].id
    scsi      = true
  }

  graphics {
    type        = "spice"
    listen_type = "address"
  }
}

resource "null_resource" "exec" {
  count      = local.num_vms
  depends_on = [libvirt_domain.vm]

  provisioner "remote-exec" {
    inline = [
      "echo $HOSTNAME > ~/setup.txt",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("~/.ssh/id_rsa")
      host        = element(libvirt_domain.vm[count.index].network_interface[0].addresses, 0)
    }
  }
}

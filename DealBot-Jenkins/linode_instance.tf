terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
  }
}

provider "linode" {
  token = var.linode_token
}

resource "linode_instance" "terraform-example" {
  label           = "terraform-example"
  image           = "linode/ubuntu20.04"
  region          = "eu-central"
  type            = "g6-nanode-1"
  authorized_keys = [var.ssh_public_key]
  root_pass       = var.ssh_password

  provisioner "remote-exec" {
    inline = [
      "cat /etc/os-release"
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_username
      host        = self.ip_address
      private_key = file(var.ssh_private_key)
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u '${var.ssh_username}' -i '${self.ip_address},' -e 'ansible_python_interpreter=/usr/bin/python3' --private_key=${var.ssh_private_key} dealbot.yml"
  }
}

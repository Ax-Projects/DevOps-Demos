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

  # provisioner "local-exec" {
  #   command = "ansible-playbook -u ${var.ssh_username} -i '${self.ip_address},' -e 'ansible_python_interpreter=/usr/bin/python3' --private-key ${var.ssh_private_key} dealbot.yml"
  # }
}

resource "local_file" "inventory_file" {
  content  = <<-EOT
  ${linode_instance.terraform-example.label} ansible_host=${linode_instance.terraform-example.ip_address} ansible_ssh_private_key_file=${var.ssh_private_key} ansible_ssh_user=${var.ssh_username}

  [linode_instances]
  ${linode_instance.terraform-example.label}
  EOT
  filename = "${path.module}/inventory.ini"
}

resource "local_file" "ansible_vars" {
  content         = <<-EOT
    ssh_username: "${var.ssh_username}"
    ssh_private_key: "${var.ssh_private_key}"
    instance_ip: "${linode_instance.terraform-example.ip_address}"
  EOT
  filename        = "ansible_vars.yml"
  file_permission = "0644"
}

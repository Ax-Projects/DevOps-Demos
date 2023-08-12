output "linode-instance-ip" {
  description = "ip address of linode demo instance"
  value = linode_instance.terraform-example.ip_address
}

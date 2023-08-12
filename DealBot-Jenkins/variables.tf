variable "ssh_username" {
  description = "ssh username"
  type        = string
  sensitive   = true
}

variable "ssh_password" {
  description = "ssh password"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "ssh public key"
  type        = string
  sensitive   = true
}

variable "ssh_private_key" {
  description = "ssh private key"
  type        = string
  sensitive   = true
}

variable "linode_token" {
  description = "linode API token"
  type        = string
  sensitive   = true
}

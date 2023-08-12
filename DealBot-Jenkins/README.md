# SimpleTerraform
A simple install of Nginx server on EC2 server

Instead of hard-coding credentials into the secret.tfvars file and risking exposing it in public remote repository,
Set an environment variables with the credentials using terraform prefix: "TF_VAR_<VARIABLE_NAME>"

$Env:TF_VAR_ssh_username = "admin"; $Env:TF_VAR_ssh_password = "password"

If you still prefer to use the secret.tfvars file, do the following steps:
    1. refactor the main.tf file to use "var.ssh_username" and "var.ssh_password" instead of the environment variables
    2. use it with the "-var-file=secret.tfvars" flag when invking terraform apply command.


# Jenkins+Terraform+Ansible Demo
In this project I will demonstrate use case of:
  using Terraform to provision an Ubuntu VM in a cloud provider --> using Ansbile to fully configure Selenium Grid in a Docker container in that VM, then starting a deal scraping telegram bot in the same VM (one of my other projects - DealBot - written in Python) --> finish with cleaning the environment and shutting down the VM in the cloud; And all the tasks will be executed automatically by Jenkins declarative pipeline using the jenkinsfile.

## Requirements
For this fully automated pipeline, You will need to meet 4 requirements:
* install Terraform and Ansible on the Jenkins server host
* have access token to the desired cloud provider - saved as a secret in the Jenkins server
* create a "secret.tfvars" file containing the login credentials - saved as a secret file in the Jenkins server
* create an ssh key for accessing cloud provider's VMs, and save its location path in the "secret.tfvars" file

### Uploading Secrets
Make sure you do not expose the secret.tfvars file in a public repository. it should be stored safely in the Jenkins server credentials management system. The pipelinie relies on the existance of these secrets in the server and refer to them in the Jenkinsfile environment section.

Watch me demonstrate using this repository and tools here:
<youtube link>
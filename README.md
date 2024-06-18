# Automated CentOS VM Setup and Ansible Deployment Using Vagrant and Docker

This project outlines a comprehensive approach to setting up a CentOS virtual machine using Vagrant, establishing secure SSH connections, and leveraging Ansible for automated configuration management and deployment. 

This structured approach provides a robust framework for managing and deploying CentOS VMs and configurations using modern DevOps tools like Vagrant, Docker, and Ansible.

The project is divided into several key stages: 

## 1) VM Creation with Vagrant :

Initialize and launch a CentOS virtual machine using a command: 

```cmd
vagrant up 
```

vagrant build my virtual machine centos 7 with configuration of my IP and add my ssh key 

### 2) SSH Connection :

We use private Key for connection : 

```cmd
ssh -i testkey root@192.168.57.200
```

If you get some issue try to clean your "known_hosts"

Debug:

```cmd
ssh -i testkey root@192.168.57.200 -v
```

## 3) Ansible Environment Setup :

Automatically start Docker Desktop using PowerShell to facilitate the Ansible environment setup:

```cmd
powershell -Command "Start-Process 'C:\\Program Files\\Docker\\Docker\\Docker Desktop.exe'"
```

Build a Docker image pre-configured with Ansible, including necessary SSH keys and playbooks, to streamline the deployment process:

```cmd
docker build -t testcentos .
```

## 4) VM Interaction with Ansible:

Run the Ansible Docker container and verify connectivity with the VM through an Ansible ping command:

```cmd
docker run -it testcentos
```

Check if we can call the VM inside the container :

```cmd
ansible -i /tmp/inventory vms -m ping
```
or 

```cmd
ansible-playbook -i /tmp/inventory /tmp/playbook.yml
```

## 5) Volume Mounting and Project Execution :

Mount a local project directory into the Docker container, enabling access to playbooks and inventory files

Run with volume project:

```cmd
docker run  -v C:/tmp/Lab_VM_Ansible_Automation/ansible-project:/tmp -it testcentos
```

Run specific Ansible playbooks within the container to install and configure software on the VM, with options for detailed debugging output:

Run playbook install_docker.yml :

```cmd
ansible-playbook -i /tmp/inventory/development /tmp/playbooks/install_docker.yml
```

Run playbook uninstall_docker.yml :

```cmd
ansible-playbook -i /tmp/inventory/development /tmp/playbooks/uninstall_docker.yml
```

Mode Debug :

```cmd
ansible-playbook -i /tmp/inventory/development -vvv /tmp/playbooks/install_docker.yml
```

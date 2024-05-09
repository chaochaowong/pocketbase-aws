# Code source

The Ansible playbooks were adapted from David Alber's JupyterHub deployment 
on AWS project, https://github.com/davidalber/jupyterhub-aws. 
Modifications include user, pocketbase, and cerbot setups as well as nginx 
configuration to enable reverse proxy.

# PocketBase AWS Ansible Playbooks

This directory contains Ansible playbooks that are run after Terraform
creates the infrastructure. If the infrastructure has not yet been
created, go back and complete the Terraform steps before running
Ansible.

The playbooks in this directory do the following:
- Set up user and authorized key 
- Set up nginx configuration to put PocketBase behind a reverse proxy 
- Install PocketBase on the EC2 instance
- Set up SSL for the PocketBase instance so that users communicate
  securely over HTTPS

## Prerequisites

You need to have Ansible installed on your local machine. Ansible
requires Python. See [Installing
Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
for full coverage of options.

A quick and self-contained option for installing is to create a
virtual environment and install Ansible into it. For instance:

```bash
# Assuming `python` is Python 3.
$ python -m venv ansible_env  # Create a virtual environment named ansible_env
$ . ansible_env/bin/activate  # Activate the virtual environment
(ansible_env) $ pip install ansible  # Install Ansible in the virtual environment
.
.
.

(ansible_env) $ ansible --version
ansible [core 2.16.4]
.
.
.
```

## Configuration

You need to do some configuration before running Ansible. Follow these
steps:
1. Copy the inventory.template file to inventory. Update the domain
   name in the new file.

   If you are not deploying pocketbase with a custom domain, use the
   EC2 instance's IP address. Note: this is not a good production
   option because SSL cannot be set up without a domain name. All
   requests in this situation will be sent as plaintext and subject to
   easy snooping. This includes your users' JupyterHub passwords, so
   if you are following this route, be absolutely certain to not reuse
   a password.

2. Copy the user-setup.yml.template to user-setup.yml. Update the path
   to your ssh public key in the new file

3. Copy the static/pocketbase.nginx.conf.template to static/pocketbase.nginx.conf. 
   Update the server name (same as the domain name) in the new file. 
   
   Again, if you are not deploying pocketbase with a custom domain, use
   the EC2 instance's IP address.

4. Copy certbot-setup.yaml.template to certbot-setup.yaml. Update your email address
   and the domain name on line 14:

   ```bash
   cmd: certbot --nginx --test-cert -n --agree-tos -m youremail --domains pocketbase.somewhere.com
   ```

## Executing the Set Up

With configuration complete, you can use Ansible to set up PocketBase
by doing:

```bash
$ ansible-playbook -i inventory setup.yaml
```

![Effect of Ansible
playbook](https://github.com/davidalber/screengifs/blob/main/jupyterhub-aws/ansible.gif)

Once this is complete, head to the configured domain (`pocketbase.somewhere.com/_/`)
in a browser and create a password for your admin user.

## Supplemental information

### ssh to the PocketBase EC2 instance
You can `ssh` to the PocketBase EC2 instance:

```bash
$ ssh ubuntu@pocketbase.somewhere.com
```

The PocketBase executable and the two directories, `pd_data` and `pd_migrations`, 
are bound to ESB and located at `/var/www/pocketbase`.

```bash
$ cd /var/www/pocketbase
$ ls
```
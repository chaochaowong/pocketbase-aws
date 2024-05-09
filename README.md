# PocketBase AWS

This repository is adopted from David Abler's [`jupyterhub-aws`](https://github.com/davidalber/jupyterhub-aws). It contains Terraform and Ansible code to set up AWS resources and deploy a Pocketbase instance.


The process is broken down into steps:
- [Set up infrastructure with Terraform](infra/README.md)
- [Configure the domain DNS record](dns-configuration.md)
- [Deny all access to SSH](deny-ssh-access.md)
- [Set up PocketBase on the EC2 instance using Ansible](playbooks/README.md)


## Acknowledgement

I would like to thank [David Alber](https://github.com/davidalber) for his guidance on DNS record configuration, Terraform configuration, and Ansible application deployment. His extensive help on debugging and troubleshotting was crucial to the completion of this project.

## Backups

AWS preserves the data on an EBS volum. The default snapshot on the EBS volum is scheduled once a day and retain them up to seven days. You can edit the snapshot policy to increase the freqeuency or the duration of retainment. Alternatively, Pocketbase provides backup service to store your PocketBase data. 

## Cost
The t4g.small EC2 instance on demand costs about $0.0168 per hour. It is about $12 ~ $12.5 a month.


The Nautilus Application development team wanted to test some applications on app servers in Stratos Datacenter. They shared some pre-requisites with the DevOps team, and packages need to be installed on app servers. Since we are already using Ansible for automating such tasks, please perform this task using Ansible as per details mentioned below:


    Create an inventory file /home/thor/playbook/inventory on jump host and add all app servers in it.

    Create an Ansible playbook /home/thor/playbook/playbook.yml to install httpd package on all  app servers using Ansible yum module.

    Make sure user thor should be able to run the playbook on jump host.

Note: Validation will try to run playbook using command ansible-playbook -i inventory playbook.yml so please make sure playbook works this way, without passing any extra arguments.


Steps

1.Move into playbook directory

```bash

cd playbook

``` 

2. Create inventory file
```bash
vi inventory

```
3. Inventory File

```bash

[app]
stapp01 ansible_user=tony ansible_ssh_password=Ir0nM@n
stapp02 ansible_user=steve ansible_ssh_password=Am3ric@
stapp03 ansible_user=banner ansible_ssh_password=BigGr33n

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

```
4. Run Inventory File

```bash

ansible all -i inventory -m ping

```
5. Create Playbook File

```bash
vi playbook.yml

```
6. Run Playbook to Install httpd package on all app servers.

```bash 

ansible-playbook -i inventory playbook.yml

```


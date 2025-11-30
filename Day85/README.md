The Nautilus DevOps team is testing various Ansible modules on servers in Stratos DC. They're currently focusing on file creation on remote hosts using Ansible. Here are the details:

a. Create an inventory file ~/playbook/inventory on jump host and include all app servers.

b. Create a playbook ~/playbook/playbook.yml to create a blank file /tmp/appdata.txt on all app servers.

c. Set the permissions of the /tmp/appdata.txt file to 0655.

d. Ensure the user/group owner of the /tmp/appdata.txt file is tony on app server 1, steve on app server 2 and banner on app server 3.

Note: Validation will execute the playbook using the command ansible-playbook -i inventory playbook.yml, so ensure the playbook functions correctly without any additional arguments.


Steps

1.Move into playbook directory

```bash

cd playbook

```

2. Create an inventory file with these contents:

```bash

vi inventory

```

3. Inventory File

```bash

[app_servers]
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
6. Run the Playbook

```bash

ansible-playbook -i inventory playbook.yml

```

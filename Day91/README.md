The Nautilus DevOps team want to install and set up a simple httpd web server on all app servers in Stratos DC. They also want to deploy a sample web page using Ansible. Therefore, write the required playbook to complete this task as per details mentioned below.

We already have an inventory file under /home/thor/ansible directory on jump host. Write a playbook playbook.yml under /home/thor/ansible directory on jump host itself. Using the playbook perform below given tasks:

1  Install httpd web server on all app servers, and make sure its service is up and running.

2   Create a file /var/www/html/index.html with content:

This is a Nautilus sample file, created using Ansible!
3    Using lineinfile Ansible module add some more content in /var/www/html/index.html file. Below is the content:

Welcome to xFusionCorp Industries!

Also make sure this new line is added at the top of the file.

    The /var/www/html/index.html file's user and group owner should be apache on all app servers.

    The /var/www/html/index.html file's permissions should be 0744 on all app servers.

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way without passing any extra arguments.


Steps 

1. Move into ansible directory

```bash 

cd ansible

```
2. Validate inventory file

```bash

ansible all -i inventory -m ping

```

3. Create Playbook File

```bash

vi playbook.yml

```
4. Run the playbook file

```bash

ansible-playbook -i inventory playbook.yml

```

5. Verify with curl

```bash
curl http://stapp01
curl http://stapp02
curl http://stapp03

```
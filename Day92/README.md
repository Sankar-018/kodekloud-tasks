task needs to be added inside the role. The inventory file ~/ansible/inventory is already present on jump host that can be used. Complete the task as per details mentioned below:

a. Update ~/ansible/playbook.yml playbook to run the httpd role on App Server 2.

b. Create a jinja2 template index.html.j2 under /home/thor/ansible/role/httpd/templates/ directory and add a line This file was created using Ansible on <respective server> (for example This file was created using Ansible on stapp01 in case of App Server 1). Also please make sure not to hard code the server name inside the template. Instead, use inventory_hostname variable to fetch the correct value.

c. Add a task inside /home/thor/ansible/role/httpd/tasks/main.yml to copy this template on App Server 2 under /var/www/html/index.html. Also make sure that /var/www/html/index.html file's permissions are 0777.

d. The user/group owner of /var/www/html/index.html file must be respective sudo user of the server (for example tony in case of stapp01).

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way without passing any extra arguments.


Steps

1. Move into ansible directory and check each files

```bash
cd ansible
ls
cat inventory
cat playbook.yml
ls role

```
2. Create index.html.j2 file

```bash

vi role/httpd/templates/index.html.j2

```
  Inside the Index.html
  
  ```bash
  <p> This file was created using Ansible on {{ inventory_hostname }} 
  ```

3. Create a Playbook and Run play book

```bash

vi playbook.yml
ansible-playbook -i inventory playbook.yml

  ```

4. Verify with curl

```bash

curl http://stapp02

```
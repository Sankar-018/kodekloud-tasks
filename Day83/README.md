Troubleshoot and Create Ansible Playbook

An Ansible playbook needs completion on the jump host, where a team member left off. Below are the details:

The inventory file /home/thor/ansible/inventory requires adjustments. The playbook must run on App Server 1 in Stratos DC. Update the inventory accordingly.

Create a playbook /home/thor/ansible/playbook.yml. Include a task to create an empty file /tmp/file.txt on App Server 1.

Note: Validation will run the playbook using the command ansible-playbook -i inventory playbook.yml. Ensure the playbook works without any additional arguments.

Steps

1.Move into ansible directory:

```bash

cd ansible
ls

```

2.Fix the inventory file:

```bash

stapp01 ansible_host=stapp01 ansible_user=tony ansible_ssh_password=Ir0nM@n ansible_ssh_common_args='-o StrictHostKeyChecking=no'

```

3.Create a playbook.yml file

4.Run the playbook command:

```bash

ansible-playbook -i inventory playbook.yml

```
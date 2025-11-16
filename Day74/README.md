Update plugins and restart jenkins

Install the following plugin

    SSH Credential
    Publish Over SSH

Go to Manage Jenkins > System > Add SSH servers > Apply:

ssh-servers

Add SSH server for Database server and Backup server

Create a freestyle job named: database-backup:

    Check build periodically and add this cron job: */10 * * * *
    Add build step > Send files or execute commands over ssh > add this lines in execute command:

```bash

mkdir -p /tmp/db-backup
mysqldump -u kodekloud_roy -p'asdfgdsd' kodekloud_db01 > /tmp/db-backup/db_$(date +%F).sql

ls -la
sudo apt install sshpass -y

sshpass -p 'H@wk3y3' scp -o StrictHostKeyChecking=no /tmp/db-backup/*.sql clint@stbkp01:/home/clint/db_backups

rm -rf /tmp/db-backup

```
 It will create dump, transfer to backup and remove the backup from db server

Build job

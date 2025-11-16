Login Jenkins, Update Plugins, and Restart

Install required plugins related to SSH

    SSH
    SSH Credentials
    SSH Bukid


Add app and storage credentials: Manage Jenkins > Credentials > Global > system > Add credentials for each App server (stapp02) server and Storage server (ststor01)

Add SSH sites in Manage Jenkins > System > SSH Sites - Added each user with credentials with port 22

Create a free-style job copy-logs

From Triggers > Build periodically > Add cronjob */7 * * * *

Add Build Steps > Execute shell script on remote host using ssh > add below lines:

```bash
sshpass -p "Bl@kW" scp -p -o StrictHostKeyChecking=no /var/log/httpd/* natasha@ststor01://usr/src/security
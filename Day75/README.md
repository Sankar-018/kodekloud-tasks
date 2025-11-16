Update plugins and restart

Install the following plugins

    SSH Build Agents

Add Credentials for three nodes

Add all three slave node following this way: Manage Jenkins > Credentials > System > Global Credentials > Add Credentials

    username
    password
    ID

Login into all App Server and install java

sudo yum install java-21-openjdk -y

Add Agent Nodes: Manage Jenkins > Nodes > Create an Agent Node:

    label
    Remote Directory
    Launch Method: Launch Agent via SSH
        Host
        Credentials

Create a freestyle job: testNode:

    Restrict where to run this job
    select node label
    Add execute shell as build step
    paste these sample lines:

echo "Hello from Agent"
pwd
echo $USER

Build job, it should be successfull

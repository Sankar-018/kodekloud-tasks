Task - Day 34 - Git Hooks

The Nautilus application development team was working on a git repository /opt/cluster.git which is cloned under /usr/src/kodekloudrepos directory present on Storage server in Stratos DC. The team want to setup a hook on this repository, please find below more details: Merge the feature branch into the master branch, but before pushing your changes complete below point. Create a post-update hook in this git repository so that whenever any changes are pushed to the master branch, it creates a release tag with name release-2023-06-15, where 2023-06-15 is supposed to be the current date. For example if today is 20th June, 2023 then the release tag must be release-2023-06-20. Make sure you test the hook at least once and create a release tag for today's release. Finally remember to push your changes. Note: Perform this task using the natasha user, and ensure the repository or existing directory permissions are not altered.


Solution

Step 1: SSH into the Storage Server

ssh natasha@ststor01

Step 2: Create the post-update hook in the bare repository

cd /opt/cluster.git/hooks

Step 3: create the post-update hook file:

sudo tee post-update > /dev/null << 'EOF'
#!/bin/sh
# post-update hook to create a daily release tag when master branch is updated

if [ "$1" = "refs/heads/master" ]; then
  echo "Creating release tag..."
  git tag "release-$(date '+%Y-%m-%d')" master
fi
EOF

Step 4: Make the hook executable

sudo chmod +x /opt/cluster.git/hooks/post-update

Verify:

ls -l /opt/cluster.git/hooks/post-update

Step 5: Merge the feature branch into master (in working clone)

cd /usr/src/kodekloudrepos/cluster
git checkout master
git merge feature

Step 6: Push changes to trigger the hook

git push origin master

When pushed, it will trigger the hook in /opt/cluster.git/hooks/post-update
and create a new tag named like:

release-2025-11-03 #current date

Step 7: Verify the release tag was created

cd /opt/cluster.git
sudo git tag

output:

release-2025-11-03



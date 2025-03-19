---
title: I now have a website.
date: 2025-03-19 18:16:21
tags:
---

# NEWS!!
I updated this site so it no longer uses the default markdown website theme GitHub provides, but rather this static site builder called "Hexo".

## What is this?
This is my personal "blog" site (there is nothing on here, I know), where *eventually* I *may* post some articles about I don't know what.

## For your convenience
This website was a pain to put online. If you couldn't get Hexo to push to GitHub like me, I have some scripts for you.

This script creates the repo locally:
```bash init.sh
hexo init website
cd website

## setup your themes and stuff here

git init .
echo "public/" > .gitignore
git add .
git commit -m "initial"
git remote add origin https://github.com/your-username/your-username.github.io.git
git push -u -f origin main
```

Note that `-f` is required to force the commit, as GitHub can often create extra files when you make a repository, and these should not be synced with the client—rather, we want our ones replacing those at remote. This use of force is not problematic, as this is the initial commit.

This script commits the local git repo to GitHub:
```bash commit.sh
sudo hexo generate
sudo hexo clean

echo "commit message? "
read commitmsg

git add .
git commit -m "$commitmsg"
git push -u origin main
```

Note that the commit script does not automaticlly pull from the github repo. This should be fine as long as you do not change it the repo any other way. If need to update your local copy, use:
`git pull`

Or, if you need to over-write everything at remote, change the last line in commit.sh to this:
`git push -u -f origin main`

The second option is not advised, but it can help resolve some version issues.


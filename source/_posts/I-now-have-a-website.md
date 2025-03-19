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

## More issues I encountered

Here are some other things worth mentioning, in case anyone has the same troubles as I had.

### Passwords not being a thing anymore

A seperate issue that occoured was that I could not authenticate with GitHub when I did git push, as they had disabled password support. In order to resolve this, I had to go to:

`GitHub Website -> Settings -> Developer Settings -> Personal access tokens -> Tokens (classic) -> Generate new token -> Generate new token (classic)`

Then, sign in and give your token a note and expiration, and select all the boxes to give permissions for everything.
After that, save the token in a file somewhere (NOT IN ANY PLACE THAT COULD BE PUSHED), and when git prompts you for a password, paste the token instead of typing out your password.

### Themes causing havok with git

To fix theme issues, I recommend that you do the following:
1. You want to go one directory above your website main directory and clone your theme (for this demo I will use the theme for this site)
    `git clone https://github.com/probberechts/hexo-theme-cactus.git cactus`
2. Remove .git in that directory
    `rm -rf cactus/.git`
3. Remove .gitignore in that directory
    `rm -rf cactus/.gitignore`
4. Move the theme directory into your site
    `mv cactus website/themes/`

### What to put in .github/workflows/pages.yml

First, find your node version.
`node --version`

Then, paste this to .github/workflows/pages.yml
```yaml .github/workflows/pages.yml
name: Pages

on:
  push:
    branches:
      - main # default branch

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          # If your repository depends on submodule, please see: https://github.com/actions/checkout
          submodules: recursive
      - name: Use Node.js 20
        uses: actions/setup-node@v4
        with:
          # ---------------------------------------------------- #
          node-version: "23.6.0"
      - name: Cache NPM dependencies
        uses: actions/cache@v4
        with:
          path: node_modules
          key: ${{ runner.OS }}-npm-cache
          restore-keys: |
            ${{ runner.OS }}-npm-cache
      - name: Install Dependencies
        run: npm install
      - name: Build
        run: npm run build
      - name: Upload Pages artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public
  deploy:
    needs: build
    permissions:
      pages: write
      id-token: write
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

At the long line, you will find node-version. Replace this with your actual node version.


# fin.